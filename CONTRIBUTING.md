# Contributing to Overpass Graph

This is a small project, and I'm the sole developer so far. I welcome other contributors!

## Development Process
We'll use GitHub to host the code base, so to develop a new feature please:
1. Fork the repository and create a new branch from master. 
2. Write tests for any functionality you've added in the rspec/lib folder.
3. Ensure the test suite passes.
4. Ensure your code follows the conventional Ruby style (2 space indentation, snake case file/variable names, [etc.](https://github.com/airbnb/ruby))
5. Initiate a pull request!

## Open Projects
As it stands, the library allows developers to create a graph represented as a hash. A helpful contribution would be to write a utility function of the OverpassGraph module that serializes the graph hash data. This could be into any widely used format a developer could persist; JSON might make sense. 

## Reporting Bugs
Report any bugs using GitHub issues.

## License
Any contribution made will be covered by the project's MIT license.