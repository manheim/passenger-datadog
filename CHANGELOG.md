# Change log

## master (unreleased)


## 1.1.0 (2018-04-27)

### New features

* Improve support for multiple supergroups. Metrics for multiple supergroups will now be prefixed with name of the supergroup. ([@krasnoukhov][])
* Record the group metrics `get_wait_list_size` and `disable_wait_list_size`. ([@krasnoukhov][])


## 1.0.0 (2018-01-17)

### Changes

* Drop support for Ruby < 2.2
* Update gem dependencies

### Bug Fixes

* Do not send empty stats from Passenger 4 to Datadog


## 0.2.1 (2015-10-23)

### Changes

* Add and enforce the use of `UTF-8` encoding. ([@rrosenblum][])
* Ownership of repo has transferred from `rrosenblum` to `manheim`. ([@rrosenblum][])


## 0.2.0 (2015-10-22)

### Changes

* Change `passenger-datadog` to do what `passenger-datatdog-daemon` did before


## 0.1.0 (2015-10-22)

* Initial release

[@rrosenblum]: https://github.com/rrosenblum
[@krasnoukhov]: https://github.com/krasnoukhov
