### Interview takehome assignment from Mega.co.nz

### Intro
For this test you should timebox yourself for 4 hours, you will not be expected to complete all the functionality in the application in that time. We are interested in your progress towards each task and how you are tackling it.
Please record the approximate times you spent on each task and at the end of the 4 hours give us an overview on how you would finish development.
You will be building a simple budgeting/expense application, feel free to look at examples available in the app store for ideas.

### Technical Requirements
- Written in Objective-C
- Should be Native, do not use web view or other web technologies
- Should have a tab control with multiple views
- iPad should have its own view(s)

### Application Requirements
- Main tabs are as follows:
  - Visual overview with charts (low priority)
  - Transaction listing (per day or per month view)
  - Category listing
- Should support recording transactions in both USD & NZD
- You should be able to edit a transaction’s datetime, value, currency and category
- You should be able to edit a category’s name and colour
- Transactions should be displayed using the appropriate category colour and text set to either white/black depending on the colour used
- Transactions in USD should display the appropriate NZD amount for the datetime in question, the API to use is https://currencylayer.com/ (free version) to retrieve the exchange rate (high priority)
- A category has a budget associated with it, a budget should be monthly in NZD/USD and if the budget has been exceeded the category should be highlighted in some way
