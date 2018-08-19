# Ad reporter

## Installation

```
git clone https://github.com/raj/effilab-test-ruby.git
cd effilab-test-ruby
bundle install
```

## Launch test

```
cd effilab-test-ruby
rspec
```

## Gem installation

```
cd effilab-test-ruby
bundle
gem build ad_reporter.gemspec
gem install ad_reporter-0.0.1.gem
```


## Usage
in repository directory
```
ruby main.rb
```
### with gem installation
just execute ad_reporter 
```
ad_reporter
```


This will create 2 files if not present :
  - ~/ad_reporter.yml
  - ~/adwords_api.yml

You will need to fill information in adwords_api.yml with information provided



## Launch with docker

```
cd effilab-test-ruby
md config
docker-compose run app
```
the config files will be in config directory


## Model diagram
![Model diagram](https://github.com/raj/effilab-test-ruby/raw/doc/update-readme/doc/diagram_ad_report.png
)


## TODO

 - create a ReporterConfig class to better manage different configuration
 - make "real" stub_request for adwords component
 - configure Workers number
 - parallelize output write process
 - Separate stats compute in a different class
 - Reporter must listen to campaigns data & send information to output manager (see PERFORMANCE WARNING)
 - Create a Queue for all Adwords requests
 - Supervise different jobs when call Adwords request in parallel (catch more errors)
 - Use a command line interface like Thor or Commander
 - Configuration from command line mist be possible
 - Separate default value in config class

## PERFORMANCE - WARNING 
 - for now if there are too much campaigns, memory will be used because Provider class wait to receive all campaigns and data to send information to class Reporter
 - As Adwords api retrieve campaign sorting by name, Provider class can send data for each campaign page (with complete data)
  - So Reporter will call OutputManager.process for each page of get_campaigns request
  - And at the end Reporter will send Statistic Information to OutputManager




# Original Effilab Notice After ...
---

# Effilab technical test for Ruby developers
This repository provided the basic configuration to focus on the API and Ruby itself rather than on how to connect to Adwords.

## Exercise
We are providing you a working `main.rb` file with some calls to the Adwords API and console outputs of fetched data.

The purpose of this app is to print to console some Adwords data:
- Each row is formatted on a given format and must be respected
  - eg. `443327128 "1.01 - Nom" [ENABLED] AdGroups:11`
- Campaigns must be ordered by ascending Id
- The last output should print the mean number of AdGroups per Campaign
  - eg. `Mean number of AdGroups per Campaign: 41`

### Our expectations
- The given code already meet the specifications, but it could be greatly improved in many ways
- You need to refactor `main.rb`
  - It should be easier to understand and maintain
  - You can create as many classes, modules and files as needed
  - Keep in mind we'll want to add some new functionalities, change the output, use another Adwords service, etc.
  - Performance matters and we'll look at how you managed to improve it
- You need to setup and provide a test suite using RSpec 3
- There are many possibilities for code optimization and performance improvements so do your best

**You will present us your work and should justify your choices**

### What do we look at ?
- The quality of your code
- The quality of your commits
- _One commit_ repository won't be accepted
- Technical choices

### How to start ?
- Run `sh ./run.sh` to setup `adwords_api.yml`.
- With the documentation we provided you, set the following values:
  - `oauth2_client_id`
  - `oauth2_client_secret`
  - `developer_token`
  - `client_customer_id`
- Run `sh ./run.sh`. It should successfully run.
- Start to work on it.
- Once you're done, send us a mail with the link.

## Resources
- Adwords URL: https://adwords.google.com
- Ruby library: https://github.com/googleads/google-api-ads-ruby/tree/master/adwords_api
- Adwords API Documentation:
  - operators: https://developers.google.com/adwords/api/docs/reference/v201710/CampaignService.Predicate.Operator
- Useful link:
  - get campaigns: https://github.com/googleads/google-api-ads-ruby/blob/master/adwords_api/examples/v201710/basic_operations/get_campaigns.rb
