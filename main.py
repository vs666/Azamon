import subprocess as sp
import pymysql
import pymysql.cursors
from datetime import datetime

ActiveUser = "GUEST"
UserMode = "N"
MAX_VALUE = 1000000

# customer_id = str(row["E-MailID"]+"@"+doj+"@"+str(row["Phone"]))
# trackid = bill_no + agencyid

# Login username, phone_no
# prints the tuple
def print_result(res):
    if len(res) > 0:
        result = [list(row.values()) for row in res]
        res = [list(res[0].keys())] + result
        col_width = max(len(str(word)) for row in res for word in row) + 2
        for row in res:
            print("".join(str(word).ljust(col_width) for word in row))
        print("\n")
    else:
        print("No elements found")


def add_to_cart(cur, con):
    global UserMode, ActiveUser
    try:
        if UserMode != "C":
            print("Error: Only Customer type users can add to cart")
            return
        cur.execute("SELECT * FROM PRODUCTS")
        print_result(cur.fetchall())
        productId = input("Enter Product ID:")
        cur.execute(
            "INSERT INTO CART (CustomerID, ProductID, Product_type) VALUES (%s, %s, %s)",
            (ActiveUser, productId, "1"),
        )
        con.commit()
    except Exception as e:
        con.rollback()
        print(">>>>>>>>>>>>>", e)


def show_purchase(cur, con):
    try:
        if UserMode != "C":
            print("Error: Only Customer type users can see cart")
            return
        bill_no = int(input("Enter the Bill number:"))
        cur.execute("SELECT * FROM PURCHASE WHERE Bill_no = %s", (bill_no))
        result = cur.fetchall()
        print_result(result)
    except Exception as e:
        print(">>>>>>>>>>>>>", e)


def SearchProduct(con, cur):
    """
    Function to implement search
    """
    try:
        print("1. Search by product name")
        print("2. Search by category name")
        print("3. Exit")

        ch = int(input("Enter choice:"))
        pr = input("Do you want to enter maximum price[Y/N]:")

        if pr == "Y":
            mprice = int(input("Enter price:"))
        else:
            mprice = MAX_VALUE

        if ch == 1:
            Pname = input("Enter product name:")
            Pname = "%" + Pname + "%"
            cur.execute(
                "SELECT Product_name, Price FROM PRODUCTS WHERE Product_name LIKE %s AND Price <= %s",
                (Pname, mprice),
            )
            res = cur.fetchall()
            cur.execute(
                "SELECT MAX(Price), MIN(Price) FROM PRODUCTS WHERE Product_name LIKE %s AND Price <= %s",
                (Pname, mprice),
            )
            mxmn = cur.fetchall()
            print_result(res)
            print_result(mxmn)

        elif ch == 2:
            Cname = input("Enter category name:")
            Cname = "%" + Cname + "%"
            cur.execute(
                "SELECT SubCategoryID FROM FALLS_UNDER WHERE SuperCategoryID LIKE %s",
                Cname,
            )
            zz = cur.fetchall()
            if len(zz) > 0:
                print("SubCategories within this category")
                print_result(zz)
            else:
                cur.execute(
                    "SELECT P.Product_name, P.Price FROM PRODUCTS P, BELONGS_TO B WHERE B.ProductID = P.ProductID AND B.CategoryID LIKE %s AND P.Price <= %s",
                    (Cname, mprice),
                )
                res = cur.fetchall()
                cur.execute(
                    "SELECT MAX(Price), MIN(Price) FROM PRODUCTS P, BELONGS_TO B WHERE B.ProductID = P.ProductID AND B.CategoryID LIKE %s AND P.Price <= %s",
                    (Cname, mprice),
                )
                mxmn = cur.fetchall()
                print_result(res)
                print_result(mxmn)
    except Exception as e:
        con.rollback()
        print(">>>>>>>>>>>>>", e)


def login(cur, con):
    global ActiveUser, UserMode

    try:
        username = input("Enter username:")
        phone = input("Enter phone:")
        cur.execute(
            "SELECT * FROM USER_TABLE WHERE Username = %s AND Phone_number = %s",
            (username, phone),
        )
        res = cur.fetchall()
        if res == None:
            print("LOGIN Failed")
        else:
            cur.execute(
                "SELECT CustomerID FROM CUSTOMER_DETAILS WHERE EmailID = %s",
                (res[0]["EmailID"]),
            )
            result = cur.fetchone()
            if result != None:
                UserMode = "C"
                ActiveUser = result["CustomerID"]
            else:
                cur.execute(
                    "SELECT SupplierID FROM SUPPLIER WHERE EmailID = %s",
                    (res[0]["EmailID"]),
                )
                result = cur.fetchone()
                if result != None:
                    UserMode = "S"
                    ActiveUser = result["SupplierID"]
                else:
                    cur.execute(
                        "SELECT AgencyID FROM AGENCY WHERE EmailID = %s",
                        (res[0]["EmailID"]),
                    )
                    result = cur.fetchone()
                    if result != None:
                        UserMode = "A"
                        ActiveUser = result["AgencyID"]
            print("LOGIN Successful")

    except Exception as e:
        con.rollback()
        print("LOGIN Failed")
        print(">>>>>>>>>>>>>", e)


def get_delivery_time(cur, con):
    global UserMode, ActiveUser
    try:
        if UserMode != "C":
            print("Error: Only Customer type users can check deliveries")
            return
        print("Pending deliveries are:")
        cur.execute(
            "SELECT Bill_number, Delivery_time FROM ORDERS JOIN DELIVERY ON (ORDERS.TrackID = DELIVERY.TrackID AND ORDERS.CustomerID = %s)",
            (ActiveUser),
        )
        res = cur.fetchall()
        print_result(res)
    except Exception as e:
        print(">>>>>>>>>>>>>", e)


# returns cart table and total price
def show_cart(con, cur):
    global UserMode, ActiveUser
    try:
        if UserMode != "C":
            print("Error: Only Customer type users can see cart")
            return
        cur.execute(
            "SELECT P.ProductID, P.Product_name, P.Brand, P.Price FROM PRODUCTS AS P, CART AS C WHERE P.ProductID = C.ProductID AND C.CustomerID = %s",
            (ActiveUser),
        )
        # cur.execute(query)
        res = cur.fetchall()
        print_result(res)
        # print("Total Price:")
        # cur.execute("SELECT SUM(Price) FROM %s", res)
        tot = 0
        if len(res) > 0:
            for it in res:
                tot = tot + float(it["Price"])
            print("Total Price: ", tot)

    except Exception as e:
        con.rollback()
        print("Cart Empty")
        # print(">>>>>>>>>>>>>", e)


# deletes an item in cart
def deletion(con, cur):
    global UserMode, ActiveUser
    try:
        if UserMode != "C":
            print("Error: Only Customer type users can delete from cart")
            return
        # cur.execute("SELECT * FROM PRODUCTS")
        # print_result(cur.fetchall())
        show_cart(con, cur)
        productId = input("Enter Product ID to delete:")
        cur.execute(
            "DELETE FROM CART WHERE CustomerID = %s AND ProductID = %s AND Product_type = %s",
            (ActiveUser, productId, "1"),
        )
        con.commit()
    except Exception as e:
        con.rollback()
        print(">>>>>>>>>>>>>", e)


def CreateUser(cur, con):
    try:
        row = {}
        print("Enter new user's details:")
        name = input("Name:")
        row["name"] = name
        row["Bdate"] = input("Birth Date (YYYY-MM-DD):")
        row["AddressL1"] = input("Address Line 1:")
        row["Street"] = input("Street:")
        row["Pincode"] = input("PIN Code:")
        row["Phone"] = str(int(input("Phone No.:")))
        row["E-MailID"] = input("E-Mail ID:")
        cur.execute(
            "INSERT INTO USER_TABLE (EmailID, Username, Address_line1, Street, Pincode, Date_of_birth, Phone_number) VALUES (%s, %s, %s, %s, %s , %s, %s)",
            (
                row["E-MailID"],
                row["name"],
                row["AddressL1"],
                row["Street"],
                row["Pincode"],
                row["Bdate"],
                row["Phone"],
            ),
        )
        con.commit()
        print("Select Category\n1. Customer\n2. Supplier\n3. Delivery Agency")
        row["Category"] = 100
        while row["Category"] > 3 or row["Category"] < 1:
            row["Category"] = int(input("Category:"))
            if row["Category"] == 1:
                doj = input("Enter Date of Joining (YYYY-MM-DD):")
                cid = str(row["E-MailID"] + "@" + doj + "@" + str(row["Phone"]))
                cur.execute(
                    "INSERT INTO CUSTOMER_DETAILS (CustomerID,Date_of_joining,EmailID) VALUES (%s,%s,%s)",
                    (cid, doj, row["E-MailID"]),
                )
                print("Your ID:", cid)
            elif row["Category"] == 2:
                cur.execute(
                    "INSERT INTO SUPPLIER (SupplierID, EmailID) VALUES (%s,%s)",
                    (str(row["E-MailID"] + str(row["Phone"])), row["E-MailID"]),
                )
                print("Your ID:", str(row["E-MailID"] + str(row["Phone"])))
            elif row["Category"] == 3:
                cur.execute(
                    "INSERT INTO AGENCY (AgencyID,EmailID) VALUES (%s,%s)",
                    (str(row["E-MailID"] + str(row["Phone"])), row["E-MailID"]),
                )
                print("Your ID:", str(row["E-MailID"] + str(row["Phone"])))
            else:
                print("ERROR: Invalid Category Selected. Retry.")
        con.commit()
        print("Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)


def add_product_supplier(cur, com):
    global UserMode, ActiveUser
    try:
        if UserMode != "S":
            print("Invalid supplier id\nExiting...")
            return

        supplier_id = ActiveUser
        p_id = input("Enter product ID:")
        p_name = input("Enter the product Name:")
        p_price = float(input("Enter the product price:"))
        p_brand = input("Enter the product brand:")

        print("Select from the following Categories")
        cur.execute("SELECT SubCategoryID FROM FALLS_UNDER")
        res = cur.fetchall()
        print_result(res)

        p_superCat = input("Enter the Category:")

        cur.execute("SELECT ProductID FROM PRODUCTS")
        res = cur.fetchall()

        flag = False
        for row in res:
            if p_id == row["ProductID"]:
                flag = True
                break

        if flag:
            print("Failed to insert into database")
            return

        cur.execute(
            "INSERT INTO PRODUCTS (ProductID, Product_name, Brand, Price) VALUES (%s, %s, %s, %s)",
            (p_id, p_name, p_brand, p_price),
        )
        com.commit()

        cur.execute(
            "INSERT INTO SELLS (ProductID, SupplierID) VALUES (%s, %s)",
            (p_id, supplier_id),
        )
        cur.execute(
            "INSERT INTO BELONGS_TO (ProductID, CategoryID) VALUES (%s, %s)",
            (p_id, p_superCat),
        )
        con.commit()
    except Exception as e:
        print(">>>>>>>>>>>>>", e)


def update_price(cur, com):
    global UserMode, ActiveUser
    try:
        if UserMode != "S":
            print("Invalid supplier id\nExiting...")
            return

        supplier_id = ActiveUser

        print(
            "Enter from the given set of products, the product id of the product you want to update price of:"
        )

        cur.execute(
            "SELECT P.ProductID, P.Product_name FROM PRODUCTS AS P, SELLS AS S WHERE P.ProductID = S.ProductID AND S.SupplierID = %s",
            (supplier_id),
        )

        res = cur.fetchall()
        print_result(res)

        product_id = input("Enter product ID:")
        price = float(input("Enter new price:"))
        cur.execute(
            "UPDATE PRODUCTS SET Price = %s WHERE ProductID = %s", (price, product_id)
        )
        com.commit()
    except Exception as e:
        con.rollback()
        print(">>>>>>>>>>>>>", e)


def place_order(cur, con):
    global UserMode, ActiveUser
    try:
        if UserMode != "C":
            print("Error: Only Customer type users can place order")
            return
        cur.execute("SELECT ProductID FROM CART WHERE Product_type = '1'")
        elem = cur.fetchall()
        print("Select Payment Mode (Company, Mode)")
        cur.execute("SELECT * FROM PAYMENT_MODE")
        print_result(cur.fetchall())
        inPcompany = input("Select Company:")
        inPmode = input("Select Mode:")

        today_date = datetime.today().strftime("%Y-%m-%d")
        today_time = datetime.today().strftime("%H:%M:%S")

        cur.execute(
            "INSERT INTO BILL (Purchase_time, Purchase_date) VALUES (%s, %s)",
            (today_time, today_date),
        )
        con.commit()

        cur.execute(
            "SELECT Bill_number FROM BILL WHERE Purchase_time = %s AND Purchase_date = %s",
            (today_time, today_date),
        )
        bno = cur.fetchone()["Bill_number"]

        # Update order and Delivery tables and Warranty tables
        for it in elem:
            cur.execute(
                "INSERT INTO PURCHASE (ProductID, Bill_no, Mode_of_payment, Payment_company) VALUES (%s, %s, %s, %s) ",
                (it["ProductID"], bno, inPmode, inPcompany),
            )
            con.commit()
            # Update warranty
            cur.execute(
                "SELECT Purchase_no from PURCHASE where ProductID = %s AND Bill_no = %s",
                (it["ProductID"], bno),
            )
            pur_no = cur.fetchone()["Purchase_no"]
            cur.execute(
                "INSERT INTO WARRANTY (Bill_num, ProductId, Purchase_num, Applicable, Warranty_period) VALUES (%s, %s, %s, %s, %s)",
                (bno, it["ProductID"], pur_no, True, "1"),
            )

        # delete all products from cart where product type is 1
        cur.execute("DELETE FROM CART WHERE Product_type = '1'")
        con.commit()

        # bno + agencyID = trackID
        # Ashwin's Code
        cur.execute(
            "SELECT U.Username, A.AgencyID FROM AGENCY A, USER_TABLE U WHERE U.EmailID = A.EmailID"
        )
        arr = cur.fetchall()
        print_result(arr)

        aid = input("Select agency id:")
        flag = False
        for row in arr:
            if row["AgencyID"] == aid:
                flag = True
                break
        if not flag:
            aid = arr[0]["AgencyID"]
            print("Wrong AgencyID:", aid, "is set as default")

        trackid = str(bno) + aid
        cur.execute(
            "INSERT INTO DELIVERY VALUES (%s, %s, %s)", (trackid, today_time, aid)
        )
        con.commit()

        # Update order
        while True:
            cur.execute(
                "SELECT * FROM CUSTOMER_DETAILS WHERE CustomerID = %s",
                (ActiveUser),
            )
            ret = cur.fetchall()
            cur.execute(
                "INSERT INTO ORDERS (TrackID, Bill_number, CustomerID) VALUES (%s, %s, %s)",
                (trackid, bno, ActiveUser),
            )
            con.commit()
            break
    except Exception as e:
        con.rollback()
        print(">>>>>>>>>>>>>", e)


def dispatch(ch, cur, con):
    """
    Function that maps helper functions to option entered
    """

    if ch == 1:
        CreateUser(cur, con)
    elif ch == 2:
        login(cur, con)
    elif ch == 3:
        SearchProduct(con, cur)
    elif ch == 4:
        show_purchase(cur, con)
    elif ch == 5:
        get_delivery_time(cur, con)
    elif ch == 6:
        add_to_cart(cur, con)
    elif ch == 7:
        deletion(con, cur)
    elif ch == 8:
        show_cart(con, cur)
    elif ch == 9:
        add_product_supplier(cur, con)
    elif ch == 10:
        update_price(cur, con)
    elif ch == 11:
        place_order(cur, con)
    else:
        print("Error: Invalid Option")


# Global
while True:
    tmp = sp.call("clear", shell=True)

    # Can be skipped if you want to hard core username and password
    username = input("Username:")
    password = input("Password:")

    try:
        # Set db name accordingly which have been create by you
        # Set host to the server's address if you don't want to use local SQL server
        con = pymysql.connect(
            host="localhost",
            user=username,
            password=password,
            port=5005,
            db="ECOM",
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=True,
        )
        tmp = sp.call("clear", shell=True)

        if con.open:
            print("Connected")
        else:
            print("Failed to connect")
            exit(0)

        tmp = input("Enter any key to CONTINUE")

        with con.cursor() as cur:
            while 1:
                tmp = sp.call("clear", shell=True)
                # Here taking example of Employee Mini-world
                print("1. Create USER")
                print("2. Login")
                print("3. Search")
                print("4. Show purchase")
                print("5. Show Pending Delivery")
                print("6. Add to cart")
                print("7. Delete from cart")
                print("8. Show products in cart")
                print("9. Add new product")
                print("10. Update price of a product")
                print("11. Place order")
                print("12. Exit")
                ch = int(input("Enter choice:"))
                tmp = sp.call("clear", shell=True)

                if ch == 12:
                    break
                dispatch(ch, cur, con)
                tmp = input("Enter any key to CONTINUE")
    except:
        tmp = sp.call("clear", shell=True)
        print(
            "Connection Refused: Either username or password is incorrect or user doesn't have access to database"
        )
        tmp = input("Enter any key to CONTINUE")