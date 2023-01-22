# TextMemoirs API

This API allows you to insert users, get all users, add texts, get texts by user and day, delete texts by id, get all texts and edit texts by id.

## Endpoints

### Insert User

Insert a user into the system.

-   Method: **POST**
-   URL: `/insertUser`
-   Body:
<code>{
    "phoneNumber": "+17707626118",
    "userName": "Test User",
    "password": "Test Password"
}</code>

### Get Users

Get all users in the system.

-   Method: **GET**
-   URL: `/getUsers`

### Add Text

Add a text to the system for a specific user.

-   Method: **POST**
-   URL: `/addText`
-   Body:
<code>{  
"phoneNumber":  "+17707626118",  "textMessage":  "Text message #3",  "creationDate":  "1/21/2023",  "creationTime":  "2:57:14 PM"  
}</code>

### Get Texts By User And Day

Get all texts for a specific user and day.

-   Method: **GET**
-   URL: `/getTextsByUserAndDay`
-   Parameters:
    -   phoneNumber: The phone number of the user.
    -   creationDate: The date of the texts in the format `MM/DD/YYYY`.

### Delete Texts By ID

Delete a specific text by ID.

-   Method: **DELETE**
-   URL: `/deleteTextsById`
-  Body:
<code>{
	"textId":  3
}</code>

 
### Edit Texts By ID

Edit a specific text by ID.

-   Method: **PUT**
-   URL: `/editTextsById`
-   Parameters:
    -   id: The ID of the text to edit.
-   Body:
<code>{
"textId":  2,
"textMessage":  "Updated text message"
}</code>

### Get All Texts

Get all texts in the database.

-   Method: **GET**
-   URL: `/getAllTexts`
