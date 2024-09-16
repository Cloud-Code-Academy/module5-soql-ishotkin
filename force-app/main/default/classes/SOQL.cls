/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Ilana Shotkin
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads() {
        List<Lead> allLeads = [SELECT Id, LastName, Company, Phone, Email FROM Lead]; // Use SOQL to get list of all Leads with desired fields

        return allLeads; // Return the list of Leads
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName() {
        List<Contact> contactsNamedJohn = [SELECT Id, Name FROM Contact WHERE FirstName = 'John']; // Use SOQL to get list of all Contacts with the desired name

        return contactsNamedJohn; // Return the list of Contacts
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName() {
        List<Contact> foundContactsList = [SELECT Id FROM Contact WHERE LastName = 'Smith' OR LastName = 'Jones']; // Query the Contacts with the given last names
        Map<Id, Contact> contactsMap = new Map<Id, Contact>(foundContactsList); // Convert the list into a map to separate the Id from the other fields
        List<Id> contactIds = new List<Id>(contactsMap.keySet()); // Assign the Ids to the a new list

        return contactIds; // Return the list of IDs
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount (Id accountId) {
        List<Opportunity> closedOppsForAcct = [SELECT Id, Name, Amount, CloseDate, AccountId, StageName FROM Opportunity WHERE AccountId = :accountId AND StageName = 'Closed Won']; // Use SOQL to get the Closed Opps for the given Account

        return closedOppsForAcct; // Return the Account's closed Opportunities
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount () {
        List<Account> allAccounts = [SELECT Id FROM Account]; // Get a list of all Accounts

        return allAccounts.size(); // Return the number of Accounts
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNextWeek () {
        Date startDate = Date.today(); // Set the beginning of the possible time frame
        Date endDate = Date.today().addDays(7); // Set the end of the possible time frame
        List<Task> nextWeeksTasks = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate >= :startDate AND ActivityDate <= :endDate]; // Find the tasks within the given timeframe
        Map<Id, Task> upcomingTasks = new Map<Id, Task>(nextWeeksTasks); // Create a Map to hold the upcoming Tasks

        return upcomingTasks; // Return the map of upcoming Tasks
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain () {
        List<Contact> contactsByEmail = [SELECT Id, Name, Email FROM Contact WHERE Email Like '%example.com']; // Get Contacts in the correct email domain

        return contactsByEmail; // Return the contacts
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String queryKeyword = '%' + keyword + '%';
        List<Opportunity> oppsByKeyword = [SELECT Id, Name FROM Opportunity WHERE Name LIKE :queryKeyword]; // Get Opportunities with the keyword in their name

        return oppsByKeyword; // Return the Opportunities
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> caseByOrigin = [SELECT Id, Subject, Origin FROM Case WHERE Origin != null AND Origin != 'Web' AND Origin != 'Email']; // Get all Cases with the desired Origin with SOQL

        return caseByOrigin; // Return the Cases
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle (String leadSource, String keyword) {
        String queryKeyword = '%' + keyword + '%'; // Prepare keyword for use in query
        List<Lead> filteredLeads = [SELECT Id, LastName, Company, Phone, Email, Title, LeadSource FROM Lead WHERE LeadSource = :leadSource OR Title LIKE :queryKeyword]; // Get Leads with desired origin or keyword
        
        return filteredLeads; // Return the Leads
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        List<Contact> contactsInAccount = [SELECT Id, LastName FROM Contact WHERE AccountId = :accountId]; // Query the Contacts from the Account
        List<String> lastNames = new List<String>(); // Create a list to hold the Contact LastNames

        if(!contactsInAccount.isEmpty()) {
            for(Contact c : contactsInAccount) {
                lastNames.add(c.LastName); // Loop through each Contact and add the LastName to the list
            }
        }

        return lastNames; // Return the list of Contact LastNames
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        List<AggregateResult> oppValue = [SELECT SUM(Amount)revenue FROM Opportunity WHERE Amount > 10000 OR StageName = :stage]; // Use AggregateQuery to get the total revenue
        Decimal oppRevenue=(Decimal)oppValue[0].get('revenue'); // Retrieve the total revenue from the query result
        
        return oppRevenue; // Return the total revenue
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> first10Accounts = [SELECT Id, Name FROM Account ORDER BY Name LIMIT 10]; // Get the first 10 Accounts alphabetically

        return first10Accounts; // Return the Accounts
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> highOpps = [SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5]; // Get the first 5 Opportunities over 100000 ordered by CLose Date
        
        return highOpps; // Return the Opportunities
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        List<Contact> birthdayPeople = [SELECT Id, Name, Birthdate FROM Contact ORDER BY Birthdate DESC LIMIT 3]; // Get the 3 contacts with the most recent birthdates
        
        return birthdayPeople; // Return the contacts
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> openCases = [SELECT Id, CreatedDate FROM Case ORDER BY CreatedDate LIMIT 10 OFFSET 5]; // Get the 10 Cases with Open status after the first 5 Cases
        
        return openCases; // Return the cases
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        List<Case> casesForAccount = [SELECT Id FROM Case WHERE AccountId = :accountId]; // Query the Cases
        Map<Id, Case> caseMap = new Map<Id, Case>(casesForAccount); // Assign the Cases to a map to get their Ids separate
        Set<Id> caseIds = new Set<Id>(caseMap.keySet()); // Assign the map keyset to the set

        return caseIds; // Return the Case's Ids
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();
        List<Account> foundAccounts = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry != :country]; // Query the Accounts
        
        for(Account a : foundAccounts) {// Loop through each Account and add the Id and Name to the map
            accountIdsToNames.put(a.Id, a.Name);
        }

        return accountIdsToNames; // Return the map of Ids and Names
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        List<Contact> foundContactList = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId]; // Get the Contact for the passed-in Id
        List<Account> foundAccountList = [SELECT Id, Name FROM Account WHERE Id = :foundContactList[0].AccountId]; // Get the Account for the found Contact
        String accountName = foundAccountList[0].Name; // Get the Account Name

        return accountName; // Return the name of the Account
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        List<Account> foundAccounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId]; // Get the Account and its child Opportunities
        
        return foundAccounts[0]; // Return the first item in the Account list
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        List<Account> foundAccounts = [SELECT Id, Name, BillingState FROM Account WHERE Id = :accountId]; // Query the Account
        String accountState = foundAccounts[0].BillingState; // Store the Account's BillingState
        List<Contact> foundContacts = [SELECT Id FROM Contact WHERE MailingState = :accountState]; // Query the Contacts
        
        return foundContacts; // Return the Contacts
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        List<Lead> foundLeads = [SELECT Id, Name, Email FROM LEAD WHERE Id IN :leadIds]; // Query the Leads
        Set<String> emailDomains = new Set<String>(); // Create a set of email domains for the Leads
        List<Account> foundAccounts; // Create the list to hold the Accounts

        for(Lead l : foundLeads) {// Loop through each Lead
            if(String.isNotBlank(l.Email)) { // Check if the email is not null
                emailDomains.add('www.' + l.Email.substring(l.Email.indexOf('@')+1)); // Add the email domain to the set
            }
        }
        
        foundAccounts = [SELECT Id, Website FROM Account WHERE Website IN :emailDomains]; // Query the Accounts
        
        return foundAccounts; // Return the list of Accounts
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        List<OpportunityLineItem> foundOppLineItems = [SELECT Id, OpportunityId, Quantity, PricebookEntryId, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :origOppId]; // Query the original Opportunity Line Items
        List<OpportunityLineItem> newOppLineItems = new List<OpportunityLineItem>(); // Create a list to hold the new line items

        for(Id i : cloneOppIds) { // Loop through each cloned Opportunity Id
            for(OpportunityLineItem olt : foundOppLineItems){ // Loop through each original line items
                Integer randomNum = (Integer)(Math.random()*3+1); // Find a random number for each of the new Opp Line Item using formula: (Integer)(Math.random()*(max-min+1)+1)
                OpportunityLineItem newLineItem = olt.clone(false, true, false, false); // Clone the original line item
                newLineItem.OpportunityId = i; // Set the OpportunityId to the current Opportunity ID that we are looping through
                newLineItem.Quantity = olt.Quantity + randomNum; // Add the random number to the quantity

                newOppLineItems.add(newLineItem); // Add the new Line Item to a list
            }
        }

        insert newOppLineItems; // Insert the new Opportunity Line Items
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
        List<Opportunity> foundOpportunities = [SELECT Id, Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won']; // Query for the Opportunities
        
        return foundOpportunities; // Return the Opportunities
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        List<Opportunity> closeWonOpps = getOpportunityDetailsForClosedWon(); //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        Map<String, Contact> accountContactMap = new Map<String, Contact>(); //Create Map to hold Account IDs and Contacts
        List<Contact> primaryContacts = [SELECT Id, FirstName, LastName, AccountId FROM Contact]; // Query the Contacts

        if(!closeWonOpps.isEmpty()) {
            if(!primaryContacts.isEmpty()) {
                for(Contact c : primaryContacts) { // Loop through each Contact
                    accountContactMap.put(c.AccountId, c); // Add the Account Id and Contact to the map
                }
                    
                for(Opportunity opp : closeWonOpps) { // Loop through each Opportunity
                    opp.Primary_Contact__c = accountContactMap.get(opp.AccountId).Id; // Update the Opportunity primary contact from accountToContactMap
                }

                update closeWonOpps; // Update the Opportunities
            }
        }
    }
}