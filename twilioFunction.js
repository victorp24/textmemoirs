const axios = require('axios');
// This is your new function. To start, set the name and path on the left.

exports.handler = async function(context, event, callback) {
  if(event.Body.startsWith("/DELETE")) {
    console.log("Entered delete branch");
    var textId = event.Body.split(" ")[1];
    let payload = { textId: textId };
    const response = await axios.delete('http://18.144.90.175:5000/deleteTextsById', {data : payload});
    
    var client = context.getTwilioClient();
    client.messages.create({
      to: event.From,
      from: event.To,
      body: response.data.message
    }, function(err, res) {
      console.log("Sent a reply successfully");
    })

  } else if (event.Body.startsWith("/EDIT")) {
    console.log("Entered edit branch");
    var textId = event.Body.split(" ")[1];
    var body = event.Body.split(" ");
    body.shift();
    body.shift();
    var textMessage = body.join(" ");
    
    let payload = { textId: textId,
                    textMessage: textMessage };
    const response = await axios.put('http://18.144.90.175:5000/editTextsById', payload);

    var client = context.getTwilioClient();
    client.messages.create({
      to: event.From,
      from: event.To,
      body: response.data.message
    }, function(err, res) {
      console.log("Sent a reply successfully");
    })

  } else {
    console.log("Entered adding text branch");
    var myDate = new Date()
    var pstDate = myDate.toLocaleString("en-US", {
      timeZone: "America/Los_Angeles"
    })
    
    var dateAndTime = pstDate.split(", ");
    console.log(dateAndTime[0]);
    console.log(dateAndTime[1]);
    
    try {
      let payload = { phoneNumber: event.To, 
                      textMessage: event.Body, 
                      creationDate: dateAndTime[0], 
                      creationTime: dateAndTime[1] 
                    };
      const response = await axios.post('http://18.144.90.175:5000/addText', payload);
      console.log("Successfully sent the text to the server.");
      console.log(payload);

      var client = context.getTwilioClient();
      client.messages.create({
        to: event.From,
        from: event.To,
        body: "TEXT ID: " + response.data.textid
      }, function(err, res) {
        console.log("Sent a reply successfully");
      })

    } catch(error) {
      console.log(error)
    }

  }
};