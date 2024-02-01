@isTest
private class TS4_defaultEntitlementTest {

	static testMethod void myUnitTest() {
		Account acc = new Account(Name='testacc');
		insert acc;

		Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
		insert con;

		Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');
		insert ass;

		Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
		insert ent;

		Entitlement ent2 = new Entitlement(Name='test2', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-10)), EndDate=Date.valueof(System.now().addYears(3)));
		insert ent2;

		EntitlementContact ec = new EntitlementContact(EntitlementId=ent.Id, ContactId=con.Id);
		insert ec;

		List<Case> listC = new list<Case>();
		List<Id> newCaseIds = new List<Id>();
		for(Integer i=0;i<20;i++){
			Case c = new Case(ContactId=con.Id, AccountId=con.AccountId, Subject='Test Subject'+i, Origin='Webform_B2B');

			listC.add(c);
		}
		test.startTest();
		insert listC;

		test.stopTest();
		for (Case caseObj:listC) {
			newCaseIds.add(caseObj.Id);
		}

		List<Case> entls = [Select EntitlementId, AssetId, ContactId, AccountId From Case Where Id in :newCaseIds];

		for (Case caseObj:entls) {

			System.debug(caseObj.Id + ' here are the values ' + caseObj.EntitlementId + ' and here ent.Id ' + ent.Id);

			System.assertEquals(caseObj.EntitlementId, ent.Id);

		}
        
		Contact con2 = new Contact(FirstName = 'Jane',
		LastName = 'Doe',
		Email='jane@doe.com', 
        AccountId=acc.Id);

		insert con2;
		Entitlement ent3 = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
		insert ent3;

		EntitlementContact ec2 = new EntitlementContact(EntitlementId=ent3.Id, ContactId=con2.Id);
		insert ec2;
        
		Case c1 = new Case(ContactId=con2.Id, AccountId=con2.AccountId, Subject='Test Subject');
		insert c1;
		//update c1;
	}
}