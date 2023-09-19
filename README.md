# CDSE-IT
# Git Project: Employee Data Retrieval

This project demonstrates how to fetch and process employee data from Firebase Storage, save it into CoreData, and display the first 400 employees in ascending order of hire date.

## Project Steps

1. **Fetch JSON Files from Firebase Storage:**
   - Use Firebase APIs to retrieve JSON files containing employee data from Firebase Storage.

2. **Fetch Models from JSON Files and Save to CoreData:**
   - Parse the JSON data into employee models.
   - Save the employee models to CoreData for local storage.

3. **Display Employee Data:**
   - Fetch the first 400 employees from CoreData in ascending order of hire date.
   - Display employee details including name, hire date, salary, and total time in the company.

## Requirements

- Xcode (or another IDE of your choice).
- Firebase project and storage setup.
- CoreData integration.

## Usage

To run the project, follow these steps:

1. Clone the repository.
2. Open the Xcode project file.
3. Build and run the project on your device or simulator.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
