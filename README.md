# FluEgg-Utilities
Utility codes related to the FluEgg project

## Synopsis

This repository contains auxiliary functions and data that extend the capabilities of the Fluvial Egg Drift Modeling software (FluEgg) beyond the simulation of egg and larvae transport.

The functions in this repository allows to detect potential spawning events. Future additions will be added and documented as well. The scripts are written in MatLab (2016b) to facilitate the integration with the FluEgg environment.

### Detection of potential spawning events
**UNDER DEVELOPMENT**
_THE ANALYSIS DOES NOT ACCOUNT FOR WATER TEMPERATURE. THUS, DETECTED EVENTS CANNOT BE CONSIDERED STRICTLY AS POTENTIAL SPWANING EVENTS. TEMPERATURE AND OTHER WATER QUALITY INFORMATION WILL BE INCLUDED IN FUTURE VERSIONS_

The first utility is a Spawning Event Anaylsis. It's primiary goal is to identify events within a period that complies certain criteria (ex. exceed a flow threshold) that are considered triggers of spawning events. Such criteria depends on flow and water properties, and species. It's the analyst (utility user) who must defined what's the criteria to be considered as a trigger.

The first example for the Spawning Events Detection is an application to Grass Carp in the Sandusky River, OH. As a reference for the flow discharge, this example uses the 30-min record from 01Jan2011 - 01Jan2017 at the Fremont USGS Station (USGS04198000).

The trigger flow is a minimum flow observed for documented spawining events. Spawning observations come from Grass Carp eggs collected during field campaigns in 2015 by the USGS-OH and the University of Toledo (OH). The collection time was corrected by the age of the eggs to obtain a spawning time. This was the reference time was when consulting the Flow Discharge records.

[//]: # (Show what the library does as concisely as possible, developers should be able to figure out **how** your project solves their problem by looking at the code example. Make sure the API you are showing off is obvious, and that your code is short and concise.)

## Motivation

[//]: # (A short description of the motivation behind the creation and maintenance of the project. This should explain **why** the project exists.)

## Installation

[//]: # Provide code examples and explanations of how to get the project.

Software requirements:
* Matlab 2015a
* HEC-DSSVue 2.0.1

## API Reference

[//]: # (Depending on the size of the project, if it is small and simple enough the reference docs can be added to the README. For medium size to larger projects it is important to at least provide a link to where the API reference docs live.)

## Tests

[//]: # (<Describe and show how to run the tests with code examples.>)

In this example the minimum flow discharge when eggs were collected was 130.64 m³/s at Fremont gage station.

Any period between 01Jan2011 and 01Jan2017 above that value was identified by the Spawning Event Analysis as a potential spawning event of Grass Carp in the Sandusky River.

The function requires the user to define:

* A file containing the spawning time and corresponding flow discharge for each spawning event (*spawning.events.2015*)
* A file containing the flow discharges at regular intervals (*Fremont.FLOWS.2011.2016.txt*)
* MatLab scripts (*spawning_events_analysis.m* and *parse_date.m*)

### Exporting DSS data
Open HEC-DSSVue

Open DSS file and select a path to data (ex.: /STATION/TYPE/VARIABLE/TIME WINDOW/FREQUENCY/NOTE)

*Menu Bar* > *Display* > *Tabulate*

*File* > *Export* (Check the following options)

* Fixed Width Columns
* Include Column headers
* Print Title

*Save as*: **filename.txt** (Save as text file)

## Contributors

We suggest you the following workflow when proposing changes to this repository

1. [Fork this project][fork] to your account.
2. [Create a branch][branch] for the change you intend to make.
3. Make your changes to your fork.
4. [Send a pull request][pr] from your fork’s branch to our `master` branch.

Using the web-based interface to make changes is fine too, and will help you
by automatically forking the project and prompting to send a pull request too.

[fork]: https://help.github.com/articles/fork-a-repo/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository
[pr]: https://help.github.com/articles/using-pull-requests/

## License
Copyright 2017 Santiago Sanatcruz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
