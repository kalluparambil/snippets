/**
 * Ref: https://youtu.be/H7WFkt6J4rs
 * How to send an email after a user submits a Form
 */

function sendEmail(e) {
  
  
  var html = HtmlService.createTemplateFromFile('email.html');
  var htmlText = html.getRawContent();
  Logger.log('htmlText = ' + htmlText);
  
  var emailTo = e.response.getRespondentEmail() ;
  var subject = 'Testing Email';
  var textBody = 'This email requires HTML Support.';
  var options = { htmlBody: htmlText};

  Logger.log('emailTo = ' + emailTo);
  Logger.log('subject = ' + subject);
  Logger.log('textBody = ' + textBody);
  Logger.log('options = ' + options.toString() );
  
  if(emailTo !== undefined){
    GmailApp.sendEmail(emailTo, subject, textBody, options)
  }
  
  
}
