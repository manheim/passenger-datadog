[![Gem Version](https://badge.fury.io/rb/passenger_datadog.svg)](https://badge.fury.io/rb/passenger_datadog)
[![Build Status](https://travis-ci.org/manheim/passenger-datadog.svg?branch=master)](https://travis-ci.org/manheim/passenger-datadog)
[![Code Climate](https://codeclimate.com/github/manheim/passenger-datadog/badges/gpa.svg)](https://codeclimate.com/github/manheim/passenger-datadog)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

# passenger-datadog

Inspired by [passengeri-datadog-monitor](https://github.com/Sjeanpierre/passenger-datadog-monitor)

This gem can be used to send stats from Passenger to Datadog. It makes use of
the command `passenger-status`, and the Ruby implementation of `statsd`
provided by [dogstatsd-ruby](https://github.com/DataDog/dogstatsd-ruby))

In order to gather stats on all Passenger instances, Passenger recommends
running `passenger-status` as `root`. Therefore, it is recommended that
`passenger_datadog` be run as `root` as well.

If running `passenger_datadog` as a user other than the user that owns the application
in Passenger, make sure that same version of Passenger is installed for both users.

## Installation
```
$ gem install passenger_datadog
```
## Support
1.x Ruby >= 2.2

0.x Ruby < 2.2

## Usage

### Typical Usage
```
$ passenger-datadog [start|stop|restart|status]
```

### Help
```
$ passenger-datadog
```
or
```
$ passenger-datadog [-h|--help]
```
