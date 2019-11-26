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
  
      //** Change below constants to reuse the code with other Forms **
      const FORM_COLLECTS_EMAIL = true;
      const EMAIL_TO = 'web@samskritabharatiusa.org';
      const HTML_TEMPLATE = 'email.html';
      const HTML_TXT_TO_REPLACE = '{!@#$%}';
      const FORM_IDX_OF_EMAIL_ID = 1; //If the email id is the second field then use index 1 to retrieve 
      const EMAIL_SUBJECT = 'Attention: Fundraising Page Work Request Submitted';
      const HTML_UNSUPPORTED_TXT = 'This email requires HTML Support.';
      
      //** Get the HTML Content **
      var html = HtmlService.createTemplateFromFile(HTML_TEMPLATE);
      var htmlText = html.getRawContent();

      //** Get values from Form **
      var form = e.source;
      var formResponses = form.getResponses();

      //** Get only the latest Form Entry **
      var formLastResponse = formResponses.length;
      var formResponse = formResponses[formLastResponse - 1];
      var itemResponses = formResponse.getItemResponses();

      //** If Form collects Email ID then gather that information **
      var formRespondentEmail = '';
      var formValues = '';
      if (FORM_COLLECTS_EMAIL){
        formRespondentEmail = e.response.getRespondentEmail();
        formValues = 'Email submitted by: ' + formRespondentEmail + '<br>';
      }
      
      //** Get all the fields from the latest Form Entry **
      for (var counter = 0; counter < itemResponses.length; counter++) {
        var itemResponse = itemResponses[counter];
        var formItem = (counter + 1).toString() 
        + ' ' + itemResponse.getItem().getTitle()
        + ': ' + itemResponse.getResponse()
        + '<br>';
        formValues = formValues + formItem;
      }
      
      //** HTML email body - Remember to customize the HTML Template file if needed **
      var htmlTextNew = htmlText.replace(HTML_TXT_TO_REPLACE, formValues);

      //** Build [YYYY-MM-DD HH:MM] and add to Email subject**
      var today = new Date();
      //Build the fromatted date YYYY-MM-DD
      var date = paddy(today.getFullYear(), 4)+'-'+paddy(today.getMonth()+1,2)+'-'+paddy(today.getDate(),2);
      //Pad with leading zeros
      var time = paddy(today.getHours(),2) + ":" + paddy(today.getMinutes(),2);
      var dateTime = '[' + date + ' ' + time +']' ;
      var subject = dateTime + ' ' + EMAIL_SUBJECT;

      //** Email To **
      var emailTo = EMAIL_TO;
      
      //** Email CC - check for valid emails **
      var emailRequester = itemResponses[FORM_IDX_OF_EMAIL_ID].getResponse();
      if(!validateEmails(emailRequester)){ //Blank out if emails are not valid
        emailRequester = ''; 
      }
      else if (formRespondentEmail !== undefined){ //If the FORM_COLLECTS_EMAIL then separate by comma
        emailRequester = ', ' + emailRequester; 
      }
      var emailcc = formRespondentEmail + emailRequester;

      //** Email Body **
      var textBody = HTML_UNSUPPORTED_TXT;
      var options = { htmlBody: htmlTextNew
                     , cc: emailcc
                    };

      //** Send Email **
      if(emailTo !== undefined){
        GmailApp.sendEmail(emailTo, subject, textBody, options)
      }
            
    }    

  catch(err) {
      Logger.log(err.toString());  
  }

  
}
