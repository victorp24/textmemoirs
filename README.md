# TextMemoirs
## nwHacks 2023 Submission by Victor Parangue, Kareem El-Wishahy, Parmvir Shergill, and Daniel Lee

Journalling is a well-established practice that has been shown to have many benefits for mental health and overall well-being. Some of the main benefits of journalling include the ability to reflect on one's thoughts and emotions,  reduce stress and anxiety, and document progress and growth. By writing down our experiences and feelings, we are able to process and understand them better, which can lead to greater self-awareness and insight. We can track our personal development, and identify the patterns and triggers that may be contributing to our stress and anxiety. Journalling is a practice that everyone can benefit from.

Text Memoirs is designed to make the benefits of journalling easy and accessible to everyone. By using a mobile text-message based journaling format, users can document their thoughts and feelings in a real-time sequential journal, as they go about their day. 

Text Memoirs utilizes Twilio’s API to receive and store user’s text messages in a CockroachDB database. The frontend interface for viewing a user’s daily journals is built using Flutter.

![Journal in action](https://drive.google.com/file/d/1EU7DHIMvgs8kcH5-ISmOsCgT6mL6_TYE/view?usp=share_link)


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
