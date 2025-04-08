CREATE DATABASE studyconnect;
USE studyconnect;

CREATE TABLE UserRole (
    URole_ID UNIQUEIDENTIFIER PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL
);

CREATE TABLE User (
    User_GUID UNIQUEIDENTIFIER PRIMARY KEY,
    URole_ID UNIQUEIDENTIFIER NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    FOREIGN KEY (URole_ID) REFERENCES UserRole(URole_ID),
    ON DELETE CASCADE
);

CREATE TABLE Group (
    Group_ID UNIQUEIDENTIFIER PRIMARY KEY,
    User_GUID UNIQUEIDENTIFIER NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    Visibility BOOLEAN NOT NULL,
    CreatedDate DATETIME NOT NULL,
    CreatedBy UNIQUEIDENTIFIER NOT NULL,
    FOREIGN KEY (User_GUID) REFERENCES User(User_GUID),
    ON DELETE CASCADE
);

CREATE TABLE GroupRole (
    GRole_ID UNIQUEIDENTIFIER PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL
);

CREATE TABLE GroupMember(
    User_GUID UNIQUEIDENTIFIER NOT NULL,
    Group_ID UNIQUEIDENTIFIER NOT NULL,
    GRole_ID UNIQUEIDENTIFIER NOT NULL,
    JoinDate DATETIME NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (User_GUID) REFERENCES User(User_GUID),
    FOREIGN KEY (Group_ID) REFERENCES Group(Group_ID),
    FOREIGN KEY (GRole_ID) REFERENCES GroupRole(GRole_ID)
    ON DELETE CASCADE
);

-- Adding a composite primary key to GroupMember
ALTER TABLE GroupMember
    ADD CONSTRAINT pk_GMConstraint PRIMARY KEY (User_GUID, Group_ID, GRole_ID);
GO

CREATE TABLE ForumCategory(
    FCategory_ID UNIQUEIDENTIFIER PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL
);

CREATE TABLE ForumPost(
    FPost_ID UNIQUEIDENTIFIER PRIMARY KEY,
    FCategory_ID UNIQUEIDENTIFIER NOT NULL,
    User_GUID UNIQUEIDENTIFIER NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Content TEXT NOT NULL,
    CreatedDate DATETIME NOT NULL,
    UpdatedDate DATETIME NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (FCategory_ID) REFERENCES ForumCategory(FCategory_ID),
    FOREIGN KEY (User_GUID) REFERENCES User(User_GUID)
);

CREATE TABLE ForumComment(
    FComment_ID UNIQUEIDENTIFIER PRIMARY KEY,
    FPost_ID UNIQUEIDENTIFIER NOT NULL,
    User_GUID UNIQUEIDENTIFIER NOT NULL,
    Content TEXT NOT NULL,
    CreatedDate DATETIME NOT NULL,
    UpdatedDate DATETIME NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (FPost_ID) REFERENCES ForumPost(FPost_ID),
    FOREIGN KEY (User_GUID) REFERENCES User(User_GUID)
);