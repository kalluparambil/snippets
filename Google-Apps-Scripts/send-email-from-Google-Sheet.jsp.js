//NOTE: Incomplete version

/**
 * Ref: https://youtu.be/ZcNmur6xiX4
 * How to send an email from a spreadsheet after a user submits a Form
 */

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

//Execute this function to send emails
function sendEmails() {

    try {

      //var colEmailIDColIndex = 2; // Change column index when needed.
      
      //********************************************
      //Change the Name of the Sheet if needed
      var sheetName = 'Form Responses 1';

      //Change the hardcoded names of Columns if needed
      var emailSubmitter = 'Email Address'; 
      var emailRequester = 'Requester Email address'; 
      var emailValidRowFlag = 'Valid Row Flag'; 
      var emailSentDateColName = 'Email Sent Date'; 
      
      //********************************************
      //Get handle of the Spreadsheet
      var ss = SpreadsheetApp.getActiveSpreadsheet();
      //Get handle of the Tab/Sheet
      var sheet = ss.getSheetByName(sheetName);

      //Define First and Last Rows to loop through
      var startRow = 2; // First row of data to process
      var lastRow = sheet.getLastRow(); // Number of rows to process

      //Get all values in the spreadsheet
      var data = sheet.getDataRange().getValues();

      //Get the index of the needed columns
      var idx_emailSubmitter = data[0].indexOf(emailSubmitter);
      var idx_emailRequester = data[0].indexOf(emailRequester);
      var idx_validRow = data[0].indexOf(emailValidRowFlag);
      var idx_emailed = data[0].indexOf(emailSentDateColName);

      //Loop through the rows and pick the values that are needed
      for (var i = 2; i<= lastRow; i++) {
        var value_emailSubmitter = sheet.getRange(i, (idx_emailSubmitter+1)).getValue();
        var value_emailRequester = sheet.getRange(i, (idx_emailRequester+1)).getValue();
        var value_validRow = sheet.getRange(i, (idx_validRow+1)).getValue();
        var value_emailed = sheet.getRange(i, (idx_emailed+1)).getValue();
        //Only do the following if the Row is valid and eMail flag has not been set
        if (value_validRow && !(value_emailed)) {
          //If emails are valid then concatenate them
          if (validateEmails(value_emailSubmitter)){
            var emailSub = value_emailSubmitter;
          }

          //We may need to make the below statement more robust. For example handle both fields when they are null
          if (validateEmails(value_emailRequester)){
            var emails = emailSub.concat(', ' + value_emailRequester, ', ' + 'web@samskritabharatiusa.org');
          }

          Logger.log(emails);

        }
      }
            
    }
  
  catch(err) {
    Logger.log(err.toString());  
  }

}
