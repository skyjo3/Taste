# Taste

Xcode 16.0

iOS 15.0

Swift 5

Best View on Simulator: iPhone SE (2022, 3rd generation)

### Steps to Run the App

$ cd < project directory >

$ pod install

Please open the "Taste.xcworkspace" file for testing and editing.

In Xcode, select a simulator or connected device, and hit Run.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

System design, code modularization, and unit testing

I focused on these 3 aspects because Fetch's products have complex information to show, so modularization could be a priority. And, according to the system requirements, testing is a priority.

<img width="1740" alt="Structure" src="https://github.com/user-attachments/assets/9e16c638-6949-4a5d-b442-712d8309ce81">


### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

A little less than 4 hours

#### Breakdown of Time & Order of Development:
1. Skeleton of codes (30m) – defining requirements and scope, creating files, and writing the basic structure of codes 
2. Unit test cases (30m) – writing the unit test cases based on the requirements
3. Actual functionalities (120m) – filling in the actual code content to achieve functionalities
4. Add extra test cases and pass all (45m) – ensuring the code pass all the test cases, making it maintainable and scalable

#### Data Flow

Here is the diagram explaining how the data flows, and how the interaction works.

![DataFlow](https://github.com/user-attachments/assets/2316bebf-7bfa-462f-bf73-e587e8bf29cb)


### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Overall, I think I prioritized the tasks pretty well. I used the strategy of designing the system with testing in mind (TDD). The only thing I would probably do differently is to do the image caching by myself (instead of using SDWebImage) to demonstrate my ability more. I decided not to do it because the recommended time is 4-5 hours.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The user interface aesthetics is the weakest part. This is intentional because the system requirements specifically mentioned that it is not the priority, compared to other funtionalities. However, with extra time, I am confident to do it extremely well. Because of my background, I am also good at collaborating with designers.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

CocoaPods 1.16.1

- SDWebImage 5.19.7

App icons were created by DALL E. Launch screen made by myself from a past project.

All icons in app are provided by Apple.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Designed in MVC architecture pattern

Code coverage: 80.6%

![Coverage](https://github.com/user-attachments/assets/412021e3-f143-455c-9e24-ac5e865b49ff)


### Five Areas in Unit Testing:

1. Network Request (success, failure and invalid data)

2. JSON Parsing (valid parsing, invalid parsing and missing fields)

3. Recipe Model Validation (initialization and invalid data)

4. UICollection Data Source (cell configuration, number of cells)

5. ListViewController (update collection when data updates, empty or non-empty data)

Note: I first focused on 1-3, and added the 4-5 after completing the functionalities.

# Results


| List View  | Sorted View | Empty View |
| ------------- | ------------- | ------------- |
| ![Simulator Screenshot - Fetch - SE3 - 2024-11-01 at 18 02 00](https://github.com/user-attachments/assets/664da35b-de0f-41a8-bde5-54761d4ac6fb) | ![Simulator Screenshot - Fetch - SE3 - 2024-11-01 at 18 02 23](https://github.com/user-attachments/assets/b55327e5-3398-4c35-8a77-beab9c747aae) | ![Simulator Screenshot - Fetch - SE3 - 2024-11-01 at 18 02 36](https://github.com/user-attachments/assets/e3bf22de-68c3-40cc-985a-22aaffca6939) |



