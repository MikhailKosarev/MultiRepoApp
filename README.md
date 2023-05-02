# MultiRepoApp

`MultiRepoApp` is the multi-repository application that allows users to view and search for repositories from Bitbucket and Github.

## Project status

The appication is under development. During the initial phase of the development, check [CHANGELOG.md](./CHANGELOG.md)  file to see the last updates. The `README` file contains description of the final functionality of the project.


## Description

This project is a Swift-based application that provides support for executing two separate network requests to Bitbucket and Github simultaneously. The network layer of the application includes functionality for constructing a BaseURL, adding parameters to the request, and processing common errors in a user-friendly manner via pop-ups.

The user interface of the application consists of two screens. The first is a table view that displays a list of loaded objects, and the second is a detail screen for a specific repository (accessed by tapping a cell). Each cell in the table view includes a user icon, title, repository description, and an indicator of the source of the data (Bitbucket or Github).

In addition to these features, the application also supports navigation via a navigation bar, swipe-to-refresh in the table view, and sorting of repositories by source (Bitbucket or Github), alphabetical order, reverse alphabetical order, or the original order. Filtering is also supported by user name, repository name, and data source.

## Installation

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the application on your desired simulator or device.

## License

[MIT](https://choosealicense.com/licenses/mit/)
