const apn = require('apn');
const fs = require('fs');
const readline = require('readline');

const path = require('path');
const config = JSON.parse(fs.readFileSync(path.join(__dirname, 'config.json'), 'utf-8'));

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

const keyPath = require( 'path' ).join(__dirname, config.keyPath)

rl.question('Enter the device token: ', (deviceToken) => {
  if (!deviceToken) {
    console.error("Error: Device token cannot be empty.");
    rl.close();
    process.exit(1);
  }

  const apnProvider = new apn.Provider({
    token: {
      key: keyPath,
      keyId: config.keyId,
      teamId: config.teamId
    },
    production: false
  });

  const notification = new apn.Notification({  
   "aps":{  
      "alert":"AlertTest",
      "badge":1,
      "sound":"default",
      "mutable-content":"1",
   },
   "payload": {
       "mediaUrl":"https://res.cloudinary.com/demo/image/upload/sample.jpg"
   }
});
  notification.topic = config.topic; 

apnProvider.send(notification, deviceToken).then(result => {
  console.log('Notification sent:', result);
  if (result.failed.length > 0) {
    console.error('Failed responses:', result.failed);
  }
  rl.close();
}).catch(error => {
  console.error('Error sending notification:', error);
  rl.close();
});
});