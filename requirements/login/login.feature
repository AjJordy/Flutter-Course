Feature: Login
As a customer
I want to be able to access my account and stay logged in
So I can view and respond to surveys quickly

Scenario: Valid credentials
Given that the client provided valid credentials
When request to log in
Then the system must send the user to the search screen
And keep the user logged in

Scenario: Invalid Credentials
Given that the client provided invalid credentials
When request to log in
Then the system should return an error message