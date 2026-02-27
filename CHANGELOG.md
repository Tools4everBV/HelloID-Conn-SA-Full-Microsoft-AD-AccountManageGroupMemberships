# Change Log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com), and this project adheres to [Semantic Versioning](https://semver.org).

## [2.0.0.0] - 2026-02-19

### Added
- Added comprehensive audit logging for all group membership operations
- Added detailed error handling and logging with line number information
- Added support for GrantMembership and RevokeMembership audit action types
- Added error tracking in audit logs for compliance and troubleshooting

### Changed
- **BREAKING**: Refactored task script to use ObjectGuid for reliable user and group identification
- Updated task error handling with separate try-catch blocks for add and remove operations
- Improved form task to log all errors to HelloID audit system
- Enhanced error messages with detailed context including user and group information
- Updated README with comprehensive documentation including requirements and remarks

### Fixed
- Fixed group membership operations to use ObjectGuid instead of relying on other identifiers for reliability

## [1.0.1] - 2022-03-05

### Added
- Added audit logging support for group membership changes

### Changed
- Updated to use new HelloID Agent capabilities
- Improved form and task integration with HelloID

## [1.0.0] - 2020-09-01

### Added
- Initial release of HelloID-Conn-SA-Full-AD-AccountManageGroupMemberships
- Basic AD user account group membership search functionality
- Form-based user selection with wildcard search support
- Display of available AD groups and current user group memberships
- Add and remove group membership functionality
- Delegated form with user-defined variables for search OU configuration
