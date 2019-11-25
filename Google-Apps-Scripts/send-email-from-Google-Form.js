/**
 * Ref: https://youtu.be/H7WFkt6J4rs
 * How to send an email after a user submits a Form. The above video only covers some code.
 * Other sites were referred and links are provided when possible.
 */

//************** FUNCTIONS **************
//Ref: https://stackoverflow.com/questions/8191764/javascript-multiple-email-regexp-validation
function validateEmails(string) {
        var regex = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
        var result = string.replace(/\s/g, "").split(/,|;/);        
        for(var i = 0;i < result.length;i++) {
            if(!regex.test(result[i])) {
                return false;
            }
        }       
        return true;
    }

//Ref: https://stackoverflow.com/questions/1267283/how-can-i-pad-a-value-with-leading-zeros
function paddy(num, padlen, padchar) {
    var pad_char = typeof padchar !== 'undefined' ? padchar : '0';
    var pad = new Array(1 + padlen).join(pad_char);
    return (pad + num).slice(-pad.length);
}

/*
function testFunctions() {

  var fu = paddy(4, 2); // 04
  Logger.log(fu);
  
  var bar = paddy(1, 4, '0'); // 0002
  Logger.log(bar);
  
}
*/

function sendEmail(e) {
  
    try {
  
      //** Get the HTML Content**
      var html = HtmlService.createTemplateFromFile('email.html');
      var htmlText = html.getRawContent();

      //** Get values from Form**
      var form = e.source;
      var formResponses = form.getResponses();

      //Get only the latest response which is stored in the Form.
      //Sting them together into one variable to add to the HTML later.
      var formLastResponse = formResponses.length;
      var formResponse = formResponses[formLastResponse - 1];
      var itemResponses = formResponse.getItemResponses();

      var formValues = 'Email submitted by: ' + e.response.getRespondentEmail() + '<br>';
      for (var counter = 0; counter < itemResponses.length; counter++) {
        var itemResponse = itemResponses[counter];
        var formItem = (counter + 1).toString() 
        + ' ' + itemResponse.getItem().getTitle()
        + ': ' + itemResponse.getResponse()
        + '<br>';
        formValues = formValues + formItem;
      }
      
      //** HTML email body **
      var htmlTextNew = htmlText.replace('{!@#$%}', formValues);

      //** email subject **
      var today = new Date();
      //Build the fromatted date YYYY-MM-DD
      var date = paddy(today.getFullYear(), 4)+'-'+paddy(today.getMonth()+1,2)+'-'+paddy(today.getDate(),2);
      //Pad with leading zeros
      var time = paddy(today.getHours(),2) + ":" + paddy(today.getMinutes(),2);
      var dateTime = '[' + date + ' ' + time +']' ;
      var subject = dateTime + ' Attention: Work Request Submitted';

      //** email to, cc **
      var emailTo = 'web@samskritabharatiusa.org';
      
      //Make sure that email is valid before building cc string.
      //Default Form validation only validates single email id.
      //Hence validating to see if the multiple email ids are good.
      var emailRequester = itemResponses[1].getResponse(); //Hardcoded to 1 as this email is the second field

      if(!validateEmails(emailRequester)){
        emailRequester = ''; 
      }
      
      var emailcc = e.response.getRespondentEmail() + ', ' + emailRequester;

      //** email body **
      var textBody = 'This email requires HTML Support.';
      var options = { htmlBody: htmlTextNew
                     , cc: emailcc
                    };

      //** send emails **
      if(emailTo !== undefined){
        GmailApp.sendEmail(emailTo, subject, textBody, options)
      }
      
    }    

  catch(err) {
      Logger.log(err.toString());  
  }

  
}
