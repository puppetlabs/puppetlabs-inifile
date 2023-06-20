<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v6.1.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v6.1.0) - 2023-06-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v6.0.0...v6.1.0)

### Added

- pdksync - (MAINT) - Allow Stdlib 9.x [#514](https://github.com/puppetlabs/puppetlabs-inifile/pull/514) ([LukasAud](https://github.com/LukasAud))

### Other

- Fix Heredoc rubocop and Disable Style/ClassAndModuleChildren where needed [#510](https://github.com/puppetlabs/puppetlabs-inifile/pull/510) ([jstraw](https://github.com/jstraw))

## [v6.0.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v6.0.0) - 2023-04-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v5.4.1...v6.0.0)

### Changed
- (CONT-783) - Add puppet 8 support/Drop puppet 6 support [#505](https://github.com/puppetlabs/puppetlabs-inifile/pull/505) ([jordanbreen28](https://github.com/jordanbreen28))

## [v5.4.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/v5.4.1) - 2023-04-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v5.4.0...v5.4.1)

### Fixed

- pdksync - (CONT-189) Remove support for RedHat6 / OracleLinux6 / Scientific6 [#492](https://github.com/puppetlabs/puppetlabs-inifile/pull/492) ([david22swan](https://github.com/david22swan))
- pdksync - (CONT-130) - Dropping Support for Debian 9 [#489](https://github.com/puppetlabs/puppetlabs-inifile/pull/489) ([jordanbreen28](https://github.com/jordanbreen28))

## [v5.4.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v5.4.0) - 2022-10-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v5.3.0...v5.4.0)

### Added

- pdksync - (GH-cat-11) Certify Support for Ubuntu 22.04 [#484](https://github.com/puppetlabs/puppetlabs-inifile/pull/484) ([david22swan](https://github.com/david22swan))
- pdksync - (GH-cat-12) Add Support for Redhat 9 [#480](https://github.com/puppetlabs/puppetlabs-inifile/pull/480) ([david22swan](https://github.com/david22swan))

### Fixed

- (MAINT) Drop support for Solaris 10, Windows Server 2008 R2, and AIX 5.3 and 6.1 [#485](https://github.com/puppetlabs/puppetlabs-inifile/pull/485) ([jordanbreen28](https://github.com/jordanbreen28))
- Fix broken idempotency with empty sections [#483](https://github.com/puppetlabs/puppetlabs-inifile/pull/483) ([kajinamit](https://github.com/kajinamit))

## [v5.3.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v5.3.0) - 2022-05-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v5.2.0...v5.3.0)

### Added

- pdksync - (FM-8922) - Add Support for Windows 2022 [#468](https://github.com/puppetlabs/puppetlabs-inifile/pull/468) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1753) - Add Support for AlmaLinux 8 [#463](https://github.com/puppetlabs/puppetlabs-inifile/pull/463) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1751) - Add Support for Rocky 8 [#462](https://github.com/puppetlabs/puppetlabs-inifile/pull/462) ([david22swan](https://github.com/david22swan))
- match section names containing prefix character (normally [) [#457](https://github.com/puppetlabs/puppetlabs-inifile/pull/457) ([tja523](https://github.com/tja523))

### Fixed

- pdksync - (GH-iac-334) Remove Support for Ubuntu 14.04/16.04 [#471](https://github.com/puppetlabs/puppetlabs-inifile/pull/471) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1787) Remove Support for CentOS 6 [#466](https://github.com/puppetlabs/puppetlabs-inifile/pull/466) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1598) - Remove Support for Debian 8 [#461](https://github.com/puppetlabs/puppetlabs-inifile/pull/461) ([david22swan](https://github.com/david22swan))

## [v5.2.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v5.2.0) - 2021-08-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v5.1.0...v5.2.0)

### Added

- pdksync - (IAC-1709) - Add Support for Debian 11 [#458](https://github.com/puppetlabs/puppetlabs-inifile/pull/458) ([david22swan](https://github.com/david22swan))

### Fixed

- (IAC-1741) Allow stdlib v8.0.0 [#459](https://github.com/puppetlabs/puppetlabs-inifile/pull/459) ([david22swan](https://github.com/david22swan))

## [v5.1.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v5.1.0) - 2021-06-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v5.0.1...v5.1.0)

### Added

- Accept Datatype Sensitive [#454](https://github.com/puppetlabs/puppetlabs-inifile/pull/454) ([cocker-cc](https://github.com/cocker-cc))

## [v5.0.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/v5.0.1) - 2021-03-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v5.0.0...v5.0.1)

### Fixed

- (IAC-149) - Removal of Unsupported Translate Module [#442](https://github.com/puppetlabs/puppetlabs-inifile/pull/442) ([david22swan](https://github.com/david22swan))

## [v5.0.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v5.0.0) - 2021-03-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v4.4.0...v5.0.0)

### Changed
- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [#432](https://github.com/puppetlabs/puppetlabs-inifile/pull/432) ([carabasdaniel](https://github.com/carabasdaniel))

## [v4.4.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v4.4.0) - 2020-12-08

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v4.3.1...v4.4.0)

### Added

- (feat) - Add Puppet 7 support [#422](https://github.com/puppetlabs/puppetlabs-inifile/pull/422) ([daianamezdrea](https://github.com/daianamezdrea))

## [v4.3.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/v4.3.1) - 2020-11-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v4.3.0...v4.3.1)

### Fixed

- (IAC-992) - Removal of inappropriate terminology [#415](https://github.com/puppetlabs/puppetlabs-inifile/pull/415) ([david22swan](https://github.com/david22swan))

## [v4.3.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v4.3.0) - 2020-09-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v4.2.0...v4.3.0)

### Added

- pdksync - (IAC-973) - Update travis/appveyor to run on new default branch `main` [#407](https://github.com/puppetlabs/puppetlabs-inifile/pull/407) ([david22swan](https://github.com/david22swan))
- Add delete_if_empty parameter to the ini_subsetting type/provider [#405](https://github.com/puppetlabs/puppetlabs-inifile/pull/405) ([mmarod](https://github.com/mmarod))
- (IAC-746) - Add ubuntu 20.04 support [#396](https://github.com/puppetlabs/puppetlabs-inifile/pull/396) ([david22swan](https://github.com/david22swan))

## [v4.2.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v4.2.0) - 2020-04-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v4.1.0...v4.2.0)

### Added

- Finish API conversion of `create_ini_settings` [#387](https://github.com/puppetlabs/puppetlabs-inifile/pull/387) ([alexjfisher](https://github.com/alexjfisher))

## [v4.1.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v4.1.0) - 2020-01-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v4.0.0...v4.1.0)

### Added

- pdksync - (FM-8581) - Debian 10 added to travis and provision file refactored [#374](https://github.com/puppetlabs/puppetlabs-inifile/pull/374) ([david22swan](https://github.com/david22swan))
- Puppet 4 functions [#373](https://github.com/puppetlabs/puppetlabs-inifile/pull/373) ([binford2k](https://github.com/binford2k))
- pdksync - "MODULES-10242 Add ubuntu14 support back to the modules" [#368](https://github.com/puppetlabs/puppetlabs-inifile/pull/368) ([sheenaajay](https://github.com/sheenaajay))
- (FM-8689) - Addition of Support for CentOS 8 [#366](https://github.com/puppetlabs/puppetlabs-inifile/pull/366) ([david22swan](https://github.com/david22swan))

## [v4.0.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v4.0.0) - 2019-11-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v3.1.0...v4.0.0)

### Added

- FM-8402 add debian 10 support [#352](https://github.com/puppetlabs/puppetlabs-inifile/pull/352) ([lionce](https://github.com/lionce))

### Changed
- pdksync - FM-8499 - remove ubuntu14 support [#363](https://github.com/puppetlabs/puppetlabs-inifile/pull/363) ([lionce](https://github.com/lionce))

## [v3.1.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v3.1.0) - 2019-08-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/v3.0.0...v3.1.0)

### Added

- FM-8222 - Port Module inifile to Litmus [#344](https://github.com/puppetlabs/puppetlabs-inifile/pull/344) ([lionce](https://github.com/lionce))
- (FM-8154) Add Windows Server 2019 support [#340](https://github.com/puppetlabs/puppetlabs-inifile/pull/340) ([eimlav](https://github.com/eimlav))
- (FM-8041) Add RedHat 8 support [#339](https://github.com/puppetlabs/puppetlabs-inifile/pull/339) ([eimlav](https://github.com/eimlav))

## [v3.0.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/v3.0.0) - 2019-05-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.5.0...v3.0.0)

### Changed
- pdksync - (MODULES-8444) - Raise lower Puppet bound [#335](https://github.com/puppetlabs/puppetlabs-inifile/pull/335) ([david22swan](https://github.com/david22swan))

### Fixed

- FM-7779 - Cleanup Inifile [#328](https://github.com/puppetlabs/puppetlabs-inifile/pull/328) ([lionce](https://github.com/lionce))

## [2.5.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.5.0) - 2019-01-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.4.0...2.5.0)

### Added

- (MODULES-8142) - Addition of support for SLES 15 [#315](https://github.com/puppetlabs/puppetlabs-inifile/pull/315) ([david22swan](https://github.com/david22swan))
- (MODULES-7560) - removed spaces from the beginning or from the end of the value [#311](https://github.com/puppetlabs/puppetlabs-inifile/pull/311) ([lionce](https://github.com/lionce))
- MODULES-1821 support empty sections [#274](https://github.com/puppetlabs/puppetlabs-inifile/pull/274) ([cjepeway](https://github.com/cjepeway))

### Fixed

- pdksync - (FM-7655) Fix rubygems-update for ruby < 2.3 [#320](https://github.com/puppetlabs/puppetlabs-inifile/pull/320) ([tphoney](https://github.com/tphoney))
- (MODULES-6714) - inifile: ensure absent not working with refreshonly = true [#313](https://github.com/puppetlabs/puppetlabs-inifile/pull/313) ([Lavinia-Dan](https://github.com/Lavinia-Dan))
- (FM-7483) - update module to the latest version [#310](https://github.com/puppetlabs/puppetlabs-inifile/pull/310) ([lionce](https://github.com/lionce))
- (FM-7331)-Fix japanese test [#308](https://github.com/puppetlabs/puppetlabs-inifile/pull/308) ([lionce](https://github.com/lionce))

## [2.4.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.4.0) - 2018-09-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.3.0...2.4.0)

### Added

- pdksync - (FM-7392) - Puppet 6 Testing Changes [#300](https://github.com/puppetlabs/puppetlabs-inifile/pull/300) ([pmcmaw](https://github.com/pmcmaw))
- pdksync - (MODULES-7658) use beaker4 in puppet-module-gems [#296](https://github.com/puppetlabs/puppetlabs-inifile/pull/296) ([tphoney](https://github.com/tphoney))
- (MODULES-7552) - Addition of support for Ubuntu 18.04 to inifile [#292](https://github.com/puppetlabs/puppetlabs-inifile/pull/292) ([david22swan](https://github.com/david22swan))

### Fixed

- (MODULES-7625) - Update README Limitations section [#293](https://github.com/puppetlabs/puppetlabs-inifile/pull/293) ([eimlav](https://github.com/eimlav))

## [2.3.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.3.0) - 2018-07-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.2.2...2.3.0)

### Added

- Nitish add force parameter to create new section [#286](https://github.com/puppetlabs/puppetlabs-inifile/pull/286) ([hsitin](https://github.com/hsitin))

### Fixed

- Handle backwards compatibility with force_new_section_creation [#288](https://github.com/puppetlabs/puppetlabs-inifile/pull/288) ([mwhahaha](https://github.com/mwhahaha))

## [2.2.2](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.2.2) - 2018-05-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.2.1...2.2.2)

### Fixed

- (FM-6932) - Fix type autoload [#275](https://github.com/puppetlabs/puppetlabs-inifile/pull/275) ([pmcmaw](https://github.com/pmcmaw))

## [2.2.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.2.1) - 2018-04-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.2.0...2.2.1)

## [2.2.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.2.0) - 2018-01-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.1.1...2.2.0)

### Added

- (MODULES-6453) - PDK convert inifile [#260](https://github.com/puppetlabs/puppetlabs-inifile/pull/260) ([pmcmaw](https://github.com/pmcmaw))

## [2.1.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.1.1) - 2017-12-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.1.0...2.1.1)

### Added

- Rubocop checks will now be run against any PRs made towards the module [#251](https://github.com/puppetlabs/puppetlabs-inifile/pull/251) ([david22swan](https://github.com/david22swan))

## [2.1.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.1.0) - 2017-12-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/2.0.0...2.1.0)

### Changed
- Updates to metadata [#247](https://github.com/puppetlabs/puppetlabs-inifile/pull/247) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-5501) - Remove unsupported Ubuntu [#245](https://github.com/puppetlabs/puppetlabs-inifile/pull/245) ([pmcmaw](https://github.com/pmcmaw))

### Other

- MODULES-3624 Allow setting indent character [#237](https://github.com/puppetlabs/puppetlabs-inifile/pull/237) ([jamesmcdonald](https://github.com/jamesmcdonald))

## [2.0.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/2.0.0) - 2017-07-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.6.0...2.0.0)

### Added

- (MODULES-5144) Prep for puppet 5 [#238](https://github.com/puppetlabs/puppetlabs-inifile/pull/238) ([hunner](https://github.com/hunner))

### Changed
- MODULES-4830 Updating Puppet version requirement [#236](https://github.com/puppetlabs/puppetlabs-inifile/pull/236) ([HelenCampbell](https://github.com/HelenCampbell))

### Fixed

- (MODULES-5172) Backwards compatible ini_file.set_value [#240](https://github.com/puppetlabs/puppetlabs-inifile/pull/240) ([mwhahaha](https://github.com/mwhahaha))
- (MODULES-4932) fix for mimicking commented settings [#239](https://github.com/puppetlabs/puppetlabs-inifile/pull/239) ([eputnam](https://github.com/eputnam))
- (MODULES-4170) Fix path validation on windows [#224](https://github.com/puppetlabs/puppetlabs-inifile/pull/224) ([mullr](https://github.com/mullr))

## [1.6.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.6.0) - 2016-09-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.5.0...1.6.0)

### Added

- Add insert_type and subsetting_key_val_separator [#208](https://github.com/puppetlabs/puppetlabs-inifile/pull/208) ([dmitryilyin](https://github.com/dmitryilyin))
- Added refreshonly Parameter [#207](https://github.com/puppetlabs/puppetlabs-inifile/pull/207) ([jonnytdevops](https://github.com/jonnytdevops))

### Fixed

- (MODULES-3472) Fix backwards compatability for create_ini_settings [#211](https://github.com/puppetlabs/puppetlabs-inifile/pull/211) ([HelenCampbell](https://github.com/HelenCampbell))
- (MODULES-3145) Cast values to strings before passing to provider [#204](https://github.com/puppetlabs/puppetlabs-inifile/pull/204) ([hunner](https://github.com/hunner))

## [1.5.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.5.0) - 2016-03-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.4.3...1.5.0)

### Added

- Remove empty sections after last setting is removed [#199](https://github.com/puppetlabs/puppetlabs-inifile/pull/199) ([hunner](https://github.com/hunner))
- Update metadata to note Debian 8 support [#198](https://github.com/puppetlabs/puppetlabs-inifile/pull/198) ([DavidS](https://github.com/DavidS))
- Added keep_secret parameter feature [#152](https://github.com/puppetlabs/puppetlabs-inifile/pull/152) ([stepanstipl](https://github.com/stepanstipl))

### Fixed

- Remove brackets from ini_setting titles to workaround PUP-4709 [#196](https://github.com/puppetlabs/puppetlabs-inifile/pull/196) ([domcleal](https://github.com/domcleal))

## [1.4.3](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.4.3) - 2015-12-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.4.2...1.4.3)

## [1.4.2](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.4.2) - 2015-09-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.4.1...1.4.2)

### Added

- Adding path to create_ini_settings resources [#185](https://github.com/puppetlabs/puppetlabs-inifile/pull/185) ([danzilio](https://github.com/danzilio))
- [MODULES-2369] Support a space as a key_val_separator [#184](https://github.com/puppetlabs/puppetlabs-inifile/pull/184) ([glarizza](https://github.com/glarizza))
- MODULES-2212 - Add use_exact_match parameter for subsettings [#182](https://github.com/puppetlabs/puppetlabs-inifile/pull/182) ([underscorgan](https://github.com/underscorgan))

### Fixed

- (MODULES-1908) Munge the setting to ensure we always strip the whitespace [#183](https://github.com/puppetlabs/puppetlabs-inifile/pull/183) ([cyberious](https://github.com/cyberious))

## [1.4.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.4.1) - 2015-07-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.4.0...1.4.1)

## [1.4.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.4.0) - 2015-07-08

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.3.0...1.4.0)

### Added

- Add support for Solaris 12 [#172](https://github.com/puppetlabs/puppetlabs-inifile/pull/172) ([drewfisher314](https://github.com/drewfisher314))

### Fixed

- MODULES-1599 Match only on space and tab whitespace after k/v separator [#171](https://github.com/puppetlabs/puppetlabs-inifile/pull/171) ([misterdorm](https://github.com/misterdorm))

## [1.3.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.3.0) - 2015-06-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.2.0...1.3.0)

### Added

- Adding the ability to change regex match for $section in inifile [#159](https://github.com/puppetlabs/puppetlabs-inifile/pull/159) ([WhatsARanjit](https://github.com/WhatsARanjit))
- Flexible key val [#139](https://github.com/puppetlabs/puppetlabs-inifile/pull/139) ([underscorgan](https://github.com/underscorgan))
- introduce create_ini_settings [#129](https://github.com/puppetlabs/puppetlabs-inifile/pull/129) ([duritong](https://github.com/duritong))

### Fixed

- Modules 1876 - Setting names containing spaces fail [#158](https://github.com/puppetlabs/puppetlabs-inifile/pull/158) ([bmjen](https://github.com/bmjen))
- Adds default values for section [#157](https://github.com/puppetlabs/puppetlabs-inifile/pull/157) ([hunner](https://github.com/hunner))
- Less restrictive setting names [#134](https://github.com/puppetlabs/puppetlabs-inifile/pull/134) ([johnsyweb](https://github.com/johnsyweb))

## [1.2.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.2.0) - 2014-11-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.1.4...1.2.0)

### Fixed

- fix issue where single characters settings were not being saved. [#126](https://github.com/puppetlabs/puppetlabs-inifile/pull/126) ([doboy](https://github.com/doboy))

## [1.1.4](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.1.4) - 2014-09-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.1.3...1.1.4)

## [1.1.3](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.1.3) - 2014-07-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.1.2...1.1.3)

## [1.1.2](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.1.2) - 2014-07-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.1.1...1.1.2)

## [1.1.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.1.1) - 2014-07-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.1.0...1.1.1)

### Fixed

- Handle quotation marks in section names [#115](https://github.com/puppetlabs/puppetlabs-inifile/pull/115) ([johnsyweb](https://github.com/johnsyweb))

## [1.1.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.1.0) - 2014-06-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.0.4...1.1.0)

## [1.0.4](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.0.4) - 2014-06-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.0.3...1.0.4)

### Added

- Add RHEL7 and Ubuntu 14.04 support. [#97](https://github.com/puppetlabs/puppetlabs-inifile/pull/97) ([apenney](https://github.com/apenney))
- Add quote_char parameter to the ini_subsetting resource type [#95](https://github.com/puppetlabs/puppetlabs-inifile/pull/95) ([mruzicka](https://github.com/mruzicka))

## [1.0.3](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.0.3) - 2014-03-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.0.1...1.0.3)

## [1.0.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.0.1) - 2014-02-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/1.0.0...1.0.1)

### Added

- Adding whitespace capability to section header regex [#59](https://github.com/puppetlabs/puppetlabs-inifile/pull/59) ([antroy](https://github.com/antroy))

### Fixed

- Update settings regexes to support settings containing square brackets [#65](https://github.com/puppetlabs/puppetlabs-inifile/pull/65) ([shrug](https://github.com/shrug))
- Support spaces in sections [#58](https://github.com/puppetlabs/puppetlabs-inifile/pull/58) ([jnewland](https://github.com/jnewland))

## [1.0.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/1.0.0) - 2013-07-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.10.3...1.0.0)

### Fixed

- Support for whitespaces in settings names [#53](https://github.com/puppetlabs/puppetlabs-inifile/pull/53) ([apenney](https://github.com/apenney))
- Properly handle empty values [#52](https://github.com/puppetlabs/puppetlabs-inifile/pull/52) ([otherwiseguy](https://github.com/otherwiseguy))
- Bug/inherited purging [#50](https://github.com/puppetlabs/puppetlabs-inifile/pull/50) ([richardc](https://github.com/richardc))
- Bug/master/better handling of quotes for subsettings [#47](https://github.com/puppetlabs/puppetlabs-inifile/pull/47) ([cprice404](https://github.com/cprice404))

## [0.10.3](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.10.3) - 2013-05-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.10.2...0.10.3)

### Fixed

- Bug/master/better handling of quotes for subsettings [#45](https://github.com/puppetlabs/puppetlabs-inifile/pull/45) ([cprice404](https://github.com/cprice404))

## [0.10.2](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.10.2) - 2013-05-22

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.10.1...0.10.2)

## [0.10.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.10.1) - 2013-05-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.10.0...0.10.1)

## [0.10.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.10.0) - 2013-04-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.9.0...0.10.0)

### Added

- Added 'ini_subsetting' custom resource type [#29](https://github.com/puppetlabs/puppetlabs-inifile/pull/29) ([kbrezina](https://github.com/kbrezina))
- Add purging support to ini file [#25](https://github.com/puppetlabs/puppetlabs-inifile/pull/25) ([bodepd](https://github.com/bodepd))

### Fixed

- guard against nil indentation values [#30](https://github.com/puppetlabs/puppetlabs-inifile/pull/30) ([bodepd](https://github.com/bodepd))

## [0.9.0](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.9.0) - 2012-11-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.0.3...0.9.0)

### Added

- Add detection for commented versions of settings [#20](https://github.com/puppetlabs/puppetlabs-inifile/pull/20) ([cprice404](https://github.com/cprice404))
- Feature/master/use existing indentation [#19](https://github.com/puppetlabs/puppetlabs-inifile/pull/19) ([cprice404](https://github.com/cprice404))
- Feature/master/tweaks to setting removal [#18](https://github.com/puppetlabs/puppetlabs-inifile/pull/18) ([cprice404](https://github.com/cprice404))
- add ensure=absent support [#17](https://github.com/puppetlabs/puppetlabs-inifile/pull/17) ([bodepd](https://github.com/bodepd))

### Fixed

- Allow values with spaces to be parsed and set [#15](https://github.com/puppetlabs/puppetlabs-inifile/pull/15) ([reidmv](https://github.com/reidmv))

## [0.0.3](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.0.3) - 2012-09-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.0.2...0.0.3)

### Added

- Allow overriding separator string between key/val pairs [#9](https://github.com/puppetlabs/puppetlabs-inifile/pull/9) ([cprice404](https://github.com/cprice404))
- Added support for colons in section names [#5](https://github.com/puppetlabs/puppetlabs-inifile/pull/5) ([jtopjian](https://github.com/jtopjian))

## [0.0.2](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.0.2) - 2012-08-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/0.0.1...0.0.2)

## [0.0.1](https://github.com/puppetlabs/puppetlabs-inifile/tree/0.0.1) - 2012-08-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-inifile/compare/74fbedcf5b0cef8e5272a95ab55fc6bd83a13228...0.0.1)
