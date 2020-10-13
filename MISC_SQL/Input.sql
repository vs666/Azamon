USE ECOM;
INSERT INTO USER_TABLE (
        EMailID,
        Username,
        Address_line1,
        Street,
        Pincode,
        Date_of_birth,
        Phone_number
    )
VALUES (
        "rapido@delivery.in",
        "Rapido Delivery",
        "C-322 Industrial Warehouse",
        "G.T. Road",
        211001,
        "2011-02-22",
        "9385777743"
    );
INSERT INTO AGENCY (EMailID, AgencyID)
VALUES ("rapido@delivery.in", "RAPIDO007");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Electronics");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Clothing");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Mechanical");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Sports");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Laptops");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Phones");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Television");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Party_Wear");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Casual_Wear");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Sports_Wear");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Football/Soccer");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Cricket");
INSERT INTO CATEGORY (CategoryID)
VALUES ("Tennis/Badminton");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Laptops", "Electronics");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Phones", "Electronics");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Television", "Electronics");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Party_Wear", "Clothing");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Casual_Wear", "Clothing");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Sports_Wear", "Clothing");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Football/Soccer", "Sports");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Cricket", "Sports");
INSERT INTO FALLS_UNDER (SubcategoryID, SuperCategoryID)
VALUES ("Tennis/Badminton", "Sports");
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES ("PUMAF99", 1000, "PUMA", "Puma Frazer 99 Shoes");
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES (
        "ADI2010",
        100,
        "Adiboss",
        "Adiboss Sports Shoes"
    );
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES (
        "Nimbus2000",
        21000,
        "Borgin&Burkes",
        "Nimbus 2000 MagickBroom"
    );
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES (
        "Barca10",
        1500,
        "Adidas",
        "Barca edition Football"
    );
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES ("MacAir", 83000, "Apple", "Mac Book Air");
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES ("S434K", 93000, "Sony", "Sony 43' 4K plasma TV");
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES ("M19WEX", 29000, "Manyavar", "Wedding Shervani");
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES (
        "BayLE9",
        1100,
        "Nike",
        "Lewandoski edition Bayern Jersey"
    );
INSERT INTO PRODUCTS (ProductID, Price, Brand, Product_name)
VALUES (
        "OneP_se",
        45500,
        "OnePlus",
        "OnePlus Special Edition"
    );
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("PUMAF99", "Tennis/Badminton");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("ADI2010", "Football");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("Nimbus2000", "Cricket");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("Barca10", "Football");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("MacAir", "Laptops");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("S434K", "Television");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("M19WEX", "Party_Wear");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("BayLE9", "Sports_Wear");
INSERT INTO BELONGS_TO (ProductID, CategoryID)
VALUES ("OneP_se", "Phones");
INSERT INTO PAYMENT_MODE (Mode, Company)
VALUES ("OnlineBanking", "Amazon Pay");
INSERT INTO PAYMENT_MODE (Mode, Company)
VALUES ("OnlineBanking", "PayTM");
INSERT INTO PAYMENT_MODE (Mode, Company)
VALUES ("Debit Card", "StateBankofIndia");
INSERT INTO PAYMENT_MODE (Mode, Company)
VALUES ("CashOnDelivery", "NoCompany");
INSERT INTO PAYMENT_MODE (Mode, Company)
VALUES ("OnlineBanking", "StateBankofIndia");