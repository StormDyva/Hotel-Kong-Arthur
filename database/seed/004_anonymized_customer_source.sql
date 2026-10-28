SET NAMES utf8mb4;
START TRANSACTION;
-- Generated from local XLSX source files; guest names are deliberately anonymized.
INSERT INTO import_batches
    (source_system, file_name, file_sha256, row_count, accepted_count, rejected_count, status)
VALUES ('ITAKEA/hoteldata', 'international_names_with_rooms_1000.xlsx', 'e829206c8c697074a7d9621ec3fc1d6d4a329bc2309270b49f63630e8fa9eee8', 1000, 1000, 0, 'completed')
ON DUPLICATE KEY UPDATE
    id = LAST_INSERT_ID(id), imported_at = CURRENT_TIMESTAMP,
    row_count = VALUES(row_count), accepted_count = VALUES(accepted_count),
    rejected_count = VALUES(rejected_count), status = VALUES(status);
SET @import_batch_id = LAST_INSERT_ID();
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0001', 'CN', 'China', 'c8e7758869a1f3514d39b860b227177be4b72f46f33010db893665e5d7b0a99c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:2', @guest_id, 'Guest', 'Imported Record 0001', 'China', 'CN', 'Spa Executive', 1, 'mid', 2577, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0002', 'MX', 'Mexico', '9525634eccaa914801788335cc73a7fda21594ea608974ffe9c8dca947c41bb1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:3', @guest_id, 'Guest', 'Imported Record 0002', 'Mexico', 'MX', 'Grand Lit', 3, 'low', 3360, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0003', 'CN', 'China', 'e042e2451a0ba31441a1b7d93e611e63fc482cf43bffc48215417eae2a30d18f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:4', @guest_id, 'Guest', 'Imported Record 0003', 'China', 'CN', 'Standard Single', 5, 'high', 6420, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0004', 'RU', 'Russia', '3c1bcbb73e3ed2555088fe4a9ff6d3523fe9985352ca64b352a2c568af791fe5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:5', @guest_id, 'Guest', 'Imported Record 0004', 'Russia', 'RU', 'LOFT Suite', 2, 'mid', 6922, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0005', 'VN', 'Vietnam', '3c3972948e66e43f4aeb5fe1b58a2c28f226190f2f86b00e1912879c1839fcd7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:6', @guest_id, 'Guest', 'Imported Record 0005', 'Vietnam', 'VN', 'Suite', 4, 'mid', 12784, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0006', 'AU', 'Australia', '35fad55b15452ffa35e330fac7f200081349a39aec04a32124c9c802495c0163')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:7', @guest_id, 'Guest', 'Imported Record 0006', 'Australia', 'AU', 'Standard Double', 10, 'high', 16700, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0007', 'AU', 'Australia', '1b70084fb03a66fa5eafc767b66d3c10bf008f47e33351cb255f9a52d576ca61')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:8', @guest_id, 'Guest', 'Imported Record 0007', 'Australia', 'AU', 'Suite', 1, 'low', 2522, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0008', 'CA', 'Canada', '2bf9a3a66a7419f2a6944eeecf2876badaafa1d47df9cddac33a09fd46163d17')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:9', @guest_id, 'Guest', 'Imported Record 0008', 'Canada', 'CA', 'LOFT Suite', 5, 'low', 15995, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0009', 'NG', 'Nigeria', '4111bdeafe42defaebfa09677a13c4ff2fd6536193757da316c88b87404f4f54')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:10', @guest_id, 'Guest', 'Imported Record 0009', 'Nigeria', 'NG', 'Standard Double', 2, 'low', 2530, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0010', 'ES', 'Spain', '6a3e8809a9bd6012392922be16371bbbe2f2269fb871d1a33335ab1b12dfc3f1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:11', @guest_id, 'Guest', 'Imported Record 0010', 'Spain', 'ES', 'Standard Double', 9, 'mid', 14400, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0011', 'JP', 'Japan', '43450314ac3b1de8ca635673308834c801ffb3ff72e440bafcaa3d4ce0f8b6fe')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:12', @guest_id, 'Guest', 'Imported Record 0011', 'Japan', 'JP', 'Grand Lit', 4, 'high', 6064, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0012', 'ES', 'Spain', '088ebe68608b26048c1e89ae18f3fd172a1d5d34699a20f88bf1eb959a0be2b4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:13', @guest_id, 'Guest', 'Imported Record 0012', 'Spain', 'ES', 'Grand Lit', 7, 'high', 12096, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0013', 'IN', 'India', '4b4b4f8a15ddcb12490aafd99327a9c47c7f5a76149fdbd35ef075c370be8a6f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:14', @guest_id, 'Guest', 'Imported Record 0013', 'India', 'IN', 'Junior Suite', 5, 'mid', 10020, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0014', 'IT', 'Italy', 'edd0c4fc2a24275f97147e065382c6cdd04763af9c9709b546b7a88420e29c6e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:15', @guest_id, 'Guest', 'Imported Record 0014', 'Italy', 'IT', 'Standard Single', 6, 'high', 7452, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0015', 'ES', 'Spain', 'c0acf8849b018b170e6358dfe1088dc4dbc4103c160088fef605682e8c1e532e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:16', @guest_id, 'Guest', 'Imported Record 0015', 'Spain', 'ES', 'Spa Executive', 3, 'high', 7935, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0016', 'GB', 'United Kingdom', 'ed68b028a099cd93d4858880bab47ff8b48db3b5a050c623f47f69274be1af27')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:17', @guest_id, 'Guest', 'Imported Record 0016', 'United Kingdom', 'GB', 'Standard Single', 8, 'low', 7272, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0017', 'CA', 'Canada', 'c1c6e176851fa8e46a6ca9e4c70a01b06901377403547d83b8f12a4288c3ca23')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:18', @guest_id, 'Guest', 'Imported Record 0017', 'Canada', 'CA', 'LOFT Suite', 6, 'high', 22686, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0018', 'RU', 'Russia', 'ba95e5afd9e6353c30c7ba892ac67ca5a88e27a9dfa10a51f43f55a7a25a69ba')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:19', @guest_id, 'Guest', 'Imported Record 0018', 'Russia', 'RU', 'Grand Lit', 9, 'mid', 10944, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0019', 'VN', 'Vietnam', '2f73f1e415b3439f8b075c0ca0f6ffd76bb229177ee0fdfe976c0e715a15a641')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:20', @guest_id, 'Guest', 'Imported Record 0019', 'Vietnam', 'VN', 'LOFT Suite', 1, 'low', 3151, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0020', 'MX', 'Mexico', '8624a015c185bd204c5d3ef881c5241a006a055767e84652c70e6ecbf9130382')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:21', @guest_id, 'Guest', 'Imported Record 0020', 'Mexico', 'MX', 'Standard Double', 2, 'low', 2432, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0021', 'IN', 'India', 'cc8e897425836851913999e32d51b8ff6f2e8564b96d578ddce70f62807114c3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:22', @guest_id, 'Guest', 'Imported Record 0021', 'India', 'IN', 'Superior Double', 3, 'low', 4389, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0022', 'NG', 'Nigeria', '50def4b71df71cc70a573aed13cfccf9076ec8403c711f65ccb0ba7a83bc5c91')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:23', @guest_id, 'Guest', 'Imported Record 0022', 'Nigeria', 'NG', 'Standard Single', 7, 'high', 10087, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0023', 'EG', 'Egypt', 'e4f059c4642591158e6984b7c94453765944729ce497f3fc273340221dc85700')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:24', @guest_id, 'Guest', 'Imported Record 0023', 'Egypt', 'EG', 'LOFT Suite', 2, 'high', 7934, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0024', 'FR', 'France', '4c8ad3e96157e63c2a79335da4cd2392649fd63ba130fe32c8a7c169c64b66b0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:25', @guest_id, 'Guest', 'Imported Record 0024', 'France', 'FR', 'Standard Double', 6, 'low', 7734, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0025', 'IN', 'India', '22d36d2746317dde7422035b1596b43e2ec12980988d12292801631feed2dbbd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:26', @guest_id, 'Guest', 'Imported Record 0025', 'India', 'IN', 'Junior Suite', 5, 'low', 10915, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0026', 'IT', 'Italy', '2d9d9c594e38ff1cab4945c939c5121387ca5ddea34f79bd42dbfd35b400e9a3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:27', @guest_id, 'Guest', 'Imported Record 0026', 'Italy', 'IT', 'Suite', 7, 'high', 21315, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0027', 'KR', 'South Korea', '935e3a78e365229c30deb37d9a31df64d0ac9c961fd36a17ec2db930379f8489')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:28', @guest_id, 'Guest', 'Imported Record 0027', 'South Korea', 'KR', 'Grand Lit', 9, 'low', 9963, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0028', 'VN', 'Vietnam', '356f60ec84f5959586f964cf65869d33c06fa15ab088c0ff02b6194181f7b049')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:29', @guest_id, 'Guest', 'Imported Record 0028', 'Vietnam', 'VN', 'LOFT Suite', 6, 'low', 19524, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0029', 'PK', 'Pakistan', 'e2d8de790a8ee080b82c075c4ac86c7602668aa98f04946ba8df522430b217b5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:30', @guest_id, 'Guest', 'Imported Record 0029', 'Pakistan', 'PK', 'Standard Double', 8, 'mid', 12072, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0030', 'MX', 'Mexico', '9b578941e4d47977d33aa8e487451fd4887eaed4b2ffe5613cfe1a1054b709ce')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:31', @guest_id, 'Guest', 'Imported Record 0030', 'Mexico', 'MX', 'Standard Single', 8, 'mid', 9272, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0031', 'BR', 'Brazil', '2e7fbf874a49b0ed6f23f6eec3c2c1c87bdd9c6fe2eeaf37dbe7eda3aff3b986')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:32', @guest_id, 'Guest', 'Imported Record 0031', 'Brazil', 'BR', 'Junior Suite', 2, 'high', 4876, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0032', 'JP', 'Japan', 'a33229938253e391600c2b9caeaed616478564740850523ec7fe4ebbd63b4dd1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:33', @guest_id, 'Guest', 'Imported Record 0032', 'Japan', 'JP', 'Standard Single', 6, 'low', 5526, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0033', 'IN', 'India', 'b1605ddd21af070c17f282247ef7eddbc2f361f57cb917697a2b6610350500c2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:34', @guest_id, 'Guest', 'Imported Record 0033', 'India', 'IN', 'Suite', 8, 'high', 24080, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0034', 'KR', 'South Korea', '606c716db44063fd7bab1ec618de95f2eee43eb980017f105f390b97787306bd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:35', @guest_id, 'Guest', 'Imported Record 0034', 'South Korea', 'KR', 'Standard Single', 7, 'mid', 7441, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0035', 'NG', 'Nigeria', 'b48388e4a1433023aa19b30d9889e5e741269757919845c8b3dea3b6ef3eebe2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:36', @guest_id, 'Guest', 'Imported Record 0035', 'Nigeria', 'NG', 'Junior Suite', 10, 'mid', 21200, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0036', 'SE', 'Sweden', 'e7433fd787e20223b52f963307d7c584be34932a93cff19b614555f4e72f5ee6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:37', @guest_id, 'Guest', 'Imported Record 0036', 'Sweden', 'SE', 'Spa Executive', 1, 'high', 2512, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0037', 'SE', 'Sweden', 'c6f0d0faf5481fc9d8edb61e9a1b4fc3ac557c80282e280167516944717251a8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:38', @guest_id, 'Guest', 'Imported Record 0037', 'Sweden', 'SE', 'Superior Double', 6, 'low', 8790, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0038', 'DE', 'Germany', 'b4c40858c9ec7481dcb6cb1756731729c0ce1d392bcd6ab1e999920447568228')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:39', @guest_id, 'Guest', 'Imported Record 0038', 'Germany', 'DE', 'Superior Double', 6, 'mid', 9192, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0039', 'CA', 'Canada', '3d2008a289c67702d39c47cd12c5c189f947f901aef8862f78fc93a9723e1f10')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:40', @guest_id, 'Guest', 'Imported Record 0039', 'Canada', 'CA', 'Junior Suite', 10, 'low', 20510, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0040', 'ES', 'Spain', '11d61967cbd02ec493bb780047df4011cfc0bedad6abff14ce9fe64c0d6d0ae1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:41', @guest_id, 'Guest', 'Imported Record 0040', 'Spain', 'ES', 'Grand Lit', 5, 'mid', 6850, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0041', 'IN', 'India', 'ca8069a4198df02aa9a86a36b76826f3f39e8fcda40eb8137eaaa794f135aaac')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:42', @guest_id, 'Guest', 'Imported Record 0041', 'India', 'IN', 'Junior Suite', 5, 'mid', 10115, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0042', 'ES', 'Spain', 'f3ee98d21b504f5e7a81b1ee45b0655fc56ee912394b09c849f0fcf4ce2be767')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:43', @guest_id, 'Guest', 'Imported Record 0042', 'Spain', 'ES', 'Standard Single', 10, 'low', 9720, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0043', 'JP', 'Japan', '7c7387c41bdd65eb5df48fbb98a9ed5a5dd262d6dd03fc98213aa517f3514a5b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:44', @guest_id, 'Guest', 'Imported Record 0043', 'Japan', 'JP', 'Junior Suite', 1, 'high', 2498, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0044', 'VN', 'Vietnam', 'd15dc544e825d0652e7c7520d679ca861323781a8e5d41cb41c07f90ac77a854')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:45', @guest_id, 'Guest', 'Imported Record 0044', 'Vietnam', 'VN', 'Standard Single', 4, 'mid', 4832, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0045', 'AU', 'Australia', 'd226c5179f68991a1ae716c1d61b387ce0f9fde99a80faa434ce7097383fc96e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:46', @guest_id, 'Guest', 'Imported Record 0045', 'Australia', 'AU', 'Spa Executive', 4, 'low', 8572, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0046', 'GB', 'United Kingdom', '523c42948429e7372ba73ed406414f287a186a53607aa0c9628c416a0372989c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:47', @guest_id, 'Guest', 'Imported Record 0046', 'United Kingdom', 'GB', 'Superior Double', 1, 'low', 1489, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0047', 'KR', 'South Korea', 'e0f62c4ddebe420f6946f35a15d54b5a40790f7a0c18457de57b449d2b09b3c1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:48', @guest_id, 'Guest', 'Imported Record 0047', 'South Korea', 'KR', 'LOFT Suite', 10, 'low', 34260, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0048', 'IT', 'Italy', '1b3bad43d5b5790711dcf34cf5b4cb8deda139467ebfc5739f8fb6f9cf3feaed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:49', @guest_id, 'Guest', 'Imported Record 0048', 'Italy', 'IT', 'Junior Suite', 7, 'low', 15295, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0049', 'JP', 'Japan', 'afe0dc6bd82d3ab6f949a11585cfeab345a98521f236fbaf87e5082d4f6bbdb3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:50', @guest_id, 'Guest', 'Imported Record 0049', 'Japan', 'JP', 'Junior Suite', 1, 'mid', 2094, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0050', 'CN', 'China', '3dc00aa391578a0893235c387d80d812e0ee6415850193821d52060c5c2a80a2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:51', @guest_id, 'Guest', 'Imported Record 0050', 'China', 'CN', 'Junior Suite', 8, 'mid', 18184, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0051', 'IN', 'India', '3b22106b6d72d3b036c14a1c1fe8444b57ffe8e4ed5caea3792c5d036d9ef496')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:52', @guest_id, 'Guest', 'Imported Record 0051', 'India', 'IN', 'Suite', 9, 'mid', 26100, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0052', 'PK', 'Pakistan', 'b13c56b70b41851e496d8fed544f212a7cbabb8c6e843af826649fdfb6b25d84')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:53', @guest_id, 'Guest', 'Imported Record 0052', 'Pakistan', 'PK', 'Grand Lit', 2, 'low', 2720, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0053', 'IN', 'India', 'a58510894f93323cfcec3d076c76a1dfbfc9976c72f661fa2d2aba2093f1084a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:54', @guest_id, 'Guest', 'Imported Record 0053', 'India', 'IN', 'Superior Double', 6, 'low', 8658, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0054', 'PK', 'Pakistan', '2f0644e2899075e720e3a920737ce7257717e22a0a45c91ba60e4aab4a743798')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:55', @guest_id, 'Guest', 'Imported Record 0054', 'Pakistan', 'PK', 'Spa Executive', 3, 'mid', 6636, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0055', 'GB', 'United Kingdom', '48021f53eb6232a43d639daa96c3578b46193cc32fa109c46e76b616774e0c97')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:56', @guest_id, 'Guest', 'Imported Record 0055', 'United Kingdom', 'GB', 'Grand Lit', 8, 'mid', 10792, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0056', 'MX', 'Mexico', 'c8dfa02079459a8cae5234a3df4b6585dad63268be877ed0120d0ad7f7b17e26')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:57', @guest_id, 'Guest', 'Imported Record 0056', 'Mexico', 'MX', 'Spa Executive', 1, 'mid', 2523, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0057', 'IT', 'Italy', 'b35bddf622c1ee86a26b23848348bd4c2e9cff3953e0cbf17cd13634d7bec58c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:58', @guest_id, 'Guest', 'Imported Record 0057', 'Italy', 'IT', 'Suite', 6, 'mid', 17934, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0058', 'NG', 'Nigeria', 'aeee580b4bf98d21aac7ce42320991f380932c268997f30db9b265a10a62e69f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:59', @guest_id, 'Guest', 'Imported Record 0058', 'Nigeria', 'NG', 'Standard Double', 9, 'mid', 13851, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0059', 'CA', 'Canada', '3a6ad9041da4c17078be3a89aa3df829b0577c825b4fca8297cef9994ade3889')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:60', @guest_id, 'Guest', 'Imported Record 0059', 'Canada', 'CA', 'Junior Suite', 8, 'low', 15456, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0060', 'ES', 'Spain', 'd2b3a4a5edd5bfe70ae6a76d914fcd0a431b62daf057caf591c5fa71cfb2191b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:61', @guest_id, 'Guest', 'Imported Record 0060', 'Spain', 'ES', 'Grand Lit', 9, 'high', 13275, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0061', 'RU', 'Russia', 'd400747895b0610cbe88ca9580dd7f65e8b62e23519f316c914d4801c7f8cb0a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:62', @guest_id, 'Guest', 'Imported Record 0061', 'Russia', 'RU', 'Grand Lit', 1, 'low', 1149, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0062', 'RU', 'Russia', '4dcae7d65958e70469f87b7e86765bfc00d176566680523b61a9ecc8aa7974f4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:63', @guest_id, 'Guest', 'Imported Record 0062', 'Russia', 'RU', 'Grand Lit', 1, 'low', 1299, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0063', 'RU', 'Russia', 'cb45e6fd0e9627d975566585b79d4c874bf255f6af1c429a82e06bd8b617a4cb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:64', @guest_id, 'Guest', 'Imported Record 0063', 'Russia', 'RU', 'Grand Lit', 8, 'high', 12288, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0064', 'CA', 'Canada', '66d70440f035e0e21cebf3e29774b31cafd446d1fa6f4358bc750bbf35245cde')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:65', @guest_id, 'Guest', 'Imported Record 0064', 'Canada', 'CA', 'LOFT Suite', 9, 'low', 27918, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0065', 'BR', 'Brazil', 'ba2a0b900d7a8b95a24e9acf69d67c2ff37e38ae77d940e5349fe35904d1f90a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:66', @guest_id, 'Guest', 'Imported Record 0065', 'Brazil', 'BR', 'Grand Lit', 7, 'high', 11872, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0066', 'AU', 'Australia', '5b3858e027a3e8678dc0a6348f01637813027d92dc520af52e12e54df3672cb9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:67', @guest_id, 'Guest', 'Imported Record 0066', 'Australia', 'AU', 'Superior Double', 2, 'mid', 3814, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0067', 'NG', 'Nigeria', 'd74b64cd4d3f92c85056e9cea735efe201d4da497b7cc8f1a1929f85287430a7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:68', @guest_id, 'Guest', 'Imported Record 0067', 'Nigeria', 'NG', 'Standard Double', 1, 'high', 1952, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0068', 'AU', 'Australia', 'e70505076678a9c1cb179cf0e83ad1cb32e6f70bb6d47ea7013011e67a94198f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:69', @guest_id, 'Guest', 'Imported Record 0068', 'Australia', 'AU', 'Standard Double', 8, 'mid', 12368, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0069', 'NG', 'Nigeria', 'f6c9df9132f31daed1dbb7fb82f4223ce6513bf58d4466a46c7100a2e093a76f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:70', @guest_id, 'Guest', 'Imported Record 0069', 'Nigeria', 'NG', 'Superior Double', 8, 'mid', 12160, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0070', 'EG', 'Egypt', 'd65dcfb2bc689cad2c14f6f417d6d782dc30e1a54bcb2f4a0a91ed28a1363fdd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:71', @guest_id, 'Guest', 'Imported Record 0070', 'Egypt', 'EG', 'Junior Suite', 2, 'mid', 4434, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0071', 'SE', 'Sweden', 'f3812e3301e023c7a5fac0fdd14312180f161285b9b32f77707edea828fd2972')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:72', @guest_id, 'Guest', 'Imported Record 0071', 'Sweden', 'SE', 'Standard Double', 5, 'low', 7315, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0072', 'US', 'United States', 'fb58e4a2b5639fc8768dab3756ef5f0e7ce2e2d896bf0c43c619ca0785496014')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:73', @guest_id, 'Guest', 'Imported Record 0072', 'United States', 'US', 'Suite', 3, 'high', 9087, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0073', 'US', 'United States', 'e3c0d77c3293dee9cbc750585639afed9f5ea2c197a8cb401978b270499a9a20')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:74', @guest_id, 'Guest', 'Imported Record 0073', 'United States', 'US', 'Standard Double', 3, 'low', 4740, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0074', 'SE', 'Sweden', '96182886dc460195b31c307a293a22d14431656bbbdc9b4a8f2ccc5502697e25')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:75', @guest_id, 'Guest', 'Imported Record 0074', 'Sweden', 'SE', 'LOFT Suite', 2, 'mid', 6532, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0075', 'JP', 'Japan', '090f8cfc3f35584a9d39d916fd2b37fd6ce37ea8b99c038028673998abfc365f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:76', @guest_id, 'Guest', 'Imported Record 0075', 'Japan', 'JP', 'Standard Double', 1, 'low', 1359, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0076', 'NG', 'Nigeria', '732ae498666d36d87aa121c73b1e9604f491d80132f325433fe85fe8198b37d4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:77', @guest_id, 'Guest', 'Imported Record 0076', 'Nigeria', 'NG', 'Grand Lit', 10, 'mid', 14710, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0077', 'KR', 'South Korea', 'aade118382dd17c245ca8722cdf1d1b85749087ee5a91b52eb315827a8310d2f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:78', @guest_id, 'Guest', 'Imported Record 0077', 'South Korea', 'KR', 'Standard Single', 2, 'low', 1824, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0078', 'US', 'United States', '75ed91f233b6120cf15f173c914da88423cebca759360e1d3f3c57ed6771bc42')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:79', @guest_id, 'Guest', 'Imported Record 0078', 'United States', 'US', 'Suite', 2, 'high', 6090, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0079', 'GB', 'United Kingdom', '20e8c20cc4edd837f211cfc451d21969de0704296b92546d4ff55a976773248c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:80', @guest_id, 'Guest', 'Imported Record 0079', 'United Kingdom', 'GB', 'Suite', 5, 'low', 13515, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0080', 'IN', 'India', '1f2ca3755f2ef3cd70d83d16a602aa0d550cc1323b3f1969f9c62b4a60561d79')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:81', @guest_id, 'Guest', 'Imported Record 0080', 'India', 'IN', 'Junior Suite', 10, 'mid', 22920, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0081', 'GB', 'United Kingdom', 'fad25ad30f074f82f4eb55d6fcb547ce994a4b2687e1809f75bc6a90aab34de0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:82', @guest_id, 'Guest', 'Imported Record 0081', 'United Kingdom', 'GB', 'Standard Single', 4, 'low', 3752, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0082', 'CN', 'China', '85ee19d919f773a7d4bb2ea5764d632d0f42f362a41eeb18424d055ed07ba5c4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:83', @guest_id, 'Guest', 'Imported Record 0082', 'China', 'CN', 'Suite', 3, 'high', 10317, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0083', 'FR', 'France', '13c536fda3b3b68edab00bbaef7916f88beb16944276f68c773bede91c66c599')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:84', @guest_id, 'Guest', 'Imported Record 0083', 'France', 'FR', 'Standard Double', 5, 'high', 8600, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0084', 'IN', 'India', 'dc60a134cdb6ed6371f887303bbed6fdd1c2e839699acc0ff0d1e15f67791b2c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:85', @guest_id, 'Guest', 'Imported Record 0084', 'India', 'IN', 'Grand Lit', 9, 'high', 12816, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0085', 'PK', 'Pakistan', '2d5e7acb86f78576260a17dff4063abc11427f60a97f9a2cf8ea2e7dc9305001')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:86', @guest_id, 'Guest', 'Imported Record 0085', 'Pakistan', 'PK', 'Standard Double', 9, 'low', 13689, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0086', 'MX', 'Mexico', '8966356391ee74bc459432ba52c49a0dd11cd8e78bd158769bcc15125f43eeee')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:87', @guest_id, 'Guest', 'Imported Record 0086', 'Mexico', 'MX', 'Junior Suite', 8, 'low', 15696, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0087', 'CA', 'Canada', '00ca7b9f4ff78dca0574e68a08dc464c9d6edcccb282f613c475e8b583ff6fc6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:88', @guest_id, 'Guest', 'Imported Record 0087', 'Canada', 'CA', 'Standard Single', 4, 'low', 4512, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0088', 'CN', 'China', '7f2a9dcb64f415143096edb7a0c41016afd9b70eabcf194bda7c15ca1d3f3180')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:89', @guest_id, 'Guest', 'Imported Record 0088', 'China', 'CN', 'LOFT Suite', 1, 'mid', 3764, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0089', 'SE', 'Sweden', '0739caa6d469ce5af8ea76661953fffc3e968c4f52ddf11e1de3423314276ac5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:90', @guest_id, 'Guest', 'Imported Record 0089', 'Sweden', 'SE', 'Standard Single', 3, 'low', 3243, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0090', 'FR', 'France', 'f5014f07a3bee46562add975c4802349d740008186c1ae405f65343c83114dd5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:91', @guest_id, 'Guest', 'Imported Record 0090', 'France', 'FR', 'Grand Lit', 3, 'high', 4329, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0091', 'BR', 'Brazil', 'dfd12dd9d1c678ad2d1d32817c05626570dcd4896a12fdce7a1d0a4e6a5f6133')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:92', @guest_id, 'Guest', 'Imported Record 0091', 'Brazil', 'BR', 'Junior Suite', 9, 'high', 19935, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0092', 'SE', 'Sweden', 'f1f1467e555d40f27ab764d79b6edf4f5e65a1793f6892ad11b7fabbde1f3b69')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:93', @guest_id, 'Guest', 'Imported Record 0092', 'Sweden', 'SE', 'Superior Double', 1, 'high', 1864, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0093', 'CN', 'China', '910bb861cbd74a660adc1cd0022e5f376c143640f22a12b0eb0ab166d3bdfa7f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:94', @guest_id, 'Guest', 'Imported Record 0093', 'China', 'CN', 'Suite', 9, 'high', 30105, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0094', 'KR', 'South Korea', '9cd7b3b2f6da0b4248289ac206c8fffaa322342f1047d60ba0f97721861c125c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:95', @guest_id, 'Guest', 'Imported Record 0094', 'South Korea', 'KR', 'Junior Suite', 7, 'high', 17143, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0095', 'VN', 'Vietnam', 'bf10ce3ebe21da6a23b585bd02279b938109a0045823e079f3c3bd1c8f283410')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:96', @guest_id, 'Guest', 'Imported Record 0095', 'Vietnam', 'VN', 'Standard Single', 4, 'mid', 4132, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0096', 'RU', 'Russia', 'ea96382aaf2083ae17ac8d2aef534ce51b45cb6bea93f99cb67571b3b174926c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:97', @guest_id, 'Guest', 'Imported Record 0096', 'Russia', 'RU', 'Suite', 10, 'mid', 30490, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0097', 'DE', 'Germany', '40ff81027b9975295c835300b62603814a0f431ae16487bc4b11b6da32f955bd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:98', @guest_id, 'Guest', 'Imported Record 0097', 'Germany', 'DE', 'Standard Double', 8, 'mid', 10536, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0098', 'DE', 'Germany', '5e08120b99041350968fdabfc9f9b3eb0dfec84d9145c498842512ac33b4a4fa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:99', @guest_id, 'Guest', 'Imported Record 0098', 'Germany', 'DE', 'LOFT Suite', 8, 'high', 30480, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0099', 'JP', 'Japan', '7dccf6408ca27ad16c12fd4a83cf23f34dc99959fb20eedac9dfeab77d918bc0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:100', @guest_id, 'Guest', 'Imported Record 0099', 'Japan', 'JP', 'Grand Lit', 8, 'mid', 9808, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0100', 'CN', 'China', 'd0afdbc6f3c8461bc6fe40ab6308873e70a2995e2b39b321988db548da0f9975')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:101', @guest_id, 'Guest', 'Imported Record 0100', 'China', 'CN', 'Suite', 7, 'mid', 20356, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0101', 'EG', 'Egypt', '609a46f7d8e262fde2958aa9960096d69d48b490b94b2413251ad4eb20750d72')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:102', @guest_id, 'Guest', 'Imported Record 0101', 'Egypt', 'EG', 'Spa Executive', 8, 'low', 18480, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0102', 'RU', 'Russia', '7528d8ef11a2465d7298273a75928a3d8a90eb9e1e62a46e7cdabdd0b0e83988')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:103', @guest_id, 'Guest', 'Imported Record 0102', 'Russia', 'RU', 'Suite', 10, 'high', 33910, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0103', 'RU', 'Russia', 'f05f043d7f6c3c99581d1b6f4bf689b859e227fdc7d93248c576bfa2d4cb9649')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:104', @guest_id, 'Guest', 'Imported Record 0103', 'Russia', 'RU', 'Standard Double', 3, 'mid', 4704, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0104', 'CA', 'Canada', 'a069f1a11597e82d160d5b574eca034e38b0f91c8d3527869b381d2368921940')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:105', @guest_id, 'Guest', 'Imported Record 0104', 'Canada', 'CA', 'Standard Single', 4, 'high', 5248, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0105', 'SE', 'Sweden', '0f908bebbe05a01cc76eb8fbe46d37dee7bfcfdbf814bb50fbd5f68179d0ffe5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:106', @guest_id, 'Guest', 'Imported Record 0105', 'Sweden', 'SE', 'Junior Suite', 6, 'high', 13236, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0106', 'VN', 'Vietnam', '4890a9e31bdd2ac9f55fce32591b21ffd2cb28fa3bc10f93d01e22869a1c63f4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:107', @guest_id, 'Guest', 'Imported Record 0106', 'Vietnam', 'VN', 'Suite', 3, 'mid', 9393, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0107', 'DE', 'Germany', 'fb660a2fbd0a5454e128a625b48314349ed3fe7e01fecfc826f72f417d726fd3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:108', @guest_id, 'Guest', 'Imported Record 0107', 'Germany', 'DE', 'Standard Single', 4, 'low', 3952, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0108', 'US', 'United States', 'b399d6ebef728965accf567c3105a36925989ea257f06ced1913e92c69484680')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:109', @guest_id, 'Guest', 'Imported Record 0108', 'United States', 'US', 'Spa Executive', 2, 'high', 5090, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0109', 'NG', 'Nigeria', 'fc4cb541ca453e51ebc4d4436903ffb963b252dc7cb13067f43c7aa971cc5892')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:110', @guest_id, 'Guest', 'Imported Record 0109', 'Nigeria', 'NG', 'Standard Double', 4, 'high', 6732, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0110', 'IT', 'Italy', '4db60c5ce6da3f3b81220280054ef49e2d786fd0b7007cae99e0301c0b252400')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:111', @guest_id, 'Guest', 'Imported Record 0110', 'Italy', 'IT', 'Superior Double', 2, 'low', 2800, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0111', 'MX', 'Mexico', 'bbe5ff96f3c888a090ec8af7a326541349356e8967a06eaad5d7abba34524893')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:112', @guest_id, 'Guest', 'Imported Record 0111', 'Mexico', 'MX', 'Grand Lit', 2, 'high', 3216, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0112', 'VN', 'Vietnam', 'f29f5f83102d3df6f257bbf0493f7a89d2dc57584da7b4cf133080aefc98bf7d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:113', @guest_id, 'Guest', 'Imported Record 0112', 'Vietnam', 'VN', 'Suite', 2, 'high', 6596, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0113', 'US', 'United States', '9a72bd3f915beee5bf8ad360e9c1ddda951fa551c22dc8cdc46081ae3d399cdf')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:114', @guest_id, 'Guest', 'Imported Record 0113', 'United States', 'US', 'Suite', 6, 'mid', 16254, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0114', 'US', 'United States', 'c680128394a06ad18ba6d6f8dba2e465287f283f308467c601222fc1f6f016b4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:115', @guest_id, 'Guest', 'Imported Record 0114', 'United States', 'US', 'Standard Single', 6, 'low', 5928, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0115', 'GB', 'United Kingdom', '53c4518d0181fa3c12d52d697436c236c92081629de3c10527f15afa0a34ea0b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:116', @guest_id, 'Guest', 'Imported Record 0115', 'United Kingdom', 'GB', 'Junior Suite', 1, 'low', 2104, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0116', 'CN', 'China', 'b2f7f4274e0f1cbe04b3f0b9afcd2c978447ce5ce28744ac0e768ab218192930')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:117', @guest_id, 'Guest', 'Imported Record 0116', 'China', 'CN', 'Standard Double', 10, 'mid', 13260, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0117', 'JP', 'Japan', '2e5a31af2a16c81cf79d11a0118974525dce32505dba8156778bc1ca4f4b116c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:118', @guest_id, 'Guest', 'Imported Record 0117', 'Japan', 'JP', 'Junior Suite', 4, 'low', 7536, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0118', 'IN', 'India', 'ee9e08a17026e7a4280dd7c1956d9d5608f2689dcf7cdbdf1388f7f2d8775a30')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:119', @guest_id, 'Guest', 'Imported Record 0118', 'India', 'IN', 'Standard Single', 10, 'mid', 11730, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0119', 'IN', 'India', 'cf434a8e35d9491f86eee4fd1fb988e8073beb45f9b3423e6484933c9de534ef')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:120', @guest_id, 'Guest', 'Imported Record 0119', 'India', 'IN', 'Grand Lit', 2, 'low', 2460, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0120', 'SE', 'Sweden', '5831ca4486b1dd2b0aad58e8fcd7128c2e3310ee40de4d82b8520880a29c135a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:121', @guest_id, 'Guest', 'Imported Record 0120', 'Sweden', 'SE', 'Standard Single', 7, 'mid', 8554, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0121', 'ES', 'Spain', '08029a2fb227ae58a49d8972daa76343b728311b13ed2793969e3c540b1cf946')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:122', @guest_id, 'Guest', 'Imported Record 0121', 'Spain', 'ES', 'Superior Double', 7, 'mid', 13447, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0122', 'PK', 'Pakistan', 'b8d8f2dc0d673c48a305ebb603b6f199f4f46880b66b3f1c11e6f858385dfec8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:123', @guest_id, 'Guest', 'Imported Record 0122', 'Pakistan', 'PK', 'Spa Executive', 8, 'mid', 20384, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0123', 'IN', 'India', '45ed55630480bc1fd0074f63b8537104b720721a35ad1c89e06b80de23aee85a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:124', @guest_id, 'Guest', 'Imported Record 0123', 'India', 'IN', 'Spa Executive', 2, 'high', 5440, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0124', 'MX', 'Mexico', 'daa3bf748f9efd2e432633eb3e5b1b4f18a6c70b6803a29eee6b1e7010877f6d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:125', @guest_id, 'Guest', 'Imported Record 0124', 'Mexico', 'MX', 'Superior Double', 6, 'low', 9864, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0125', 'IT', 'Italy', '9d5e021a631c1370bc8907ba43f9d66231950abb5e9b71aacba5deefa81bff58')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:126', @guest_id, 'Guest', 'Imported Record 0125', 'Italy', 'IT', 'Superior Double', 2, 'low', 3310, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0126', 'ES', 'Spain', 'fa024ee2f57d8997ae3d8eb7e0b18c25198aa011821f44e63f2d18710f1e6493')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:127', @guest_id, 'Guest', 'Imported Record 0126', 'Spain', 'ES', 'Junior Suite', 2, 'mid', 4440, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0127', 'MX', 'Mexico', '0fcf986586083f8987435584e8ad2e4aeb326c8fb90980ab3a6a200d816a7fa7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:128', @guest_id, 'Guest', 'Imported Record 0127', 'Mexico', 'MX', 'Superior Double', 1, 'mid', 1966, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0128', 'VN', 'Vietnam', 'a5ca58f78f6fa97473acc5f0ae71f65584c6ab7c94e9a54a8806da760796e229')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:129', @guest_id, 'Guest', 'Imported Record 0128', 'Vietnam', 'VN', 'Standard Single', 5, 'low', 5685, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0129', 'DE', 'Germany', 'c782577378cba3b6b4ba4143a0afdedfc90b498a3d05725e23236c3d1f696872')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:130', @guest_id, 'Guest', 'Imported Record 0129', 'Germany', 'DE', 'Superior Double', 5, 'mid', 9640, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0130', 'ES', 'Spain', '128106f8017ae99136fe974717b059ad467fdcb7fe4d48e4dbf1bf55873e4381')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:131', @guest_id, 'Guest', 'Imported Record 0130', 'Spain', 'ES', 'Junior Suite', 2, 'mid', 4118, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0131', 'PK', 'Pakistan', '5febade8a352fbcfe699c240238e77eef5523ea1f3549599a359a38a11dee301')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:132', @guest_id, 'Guest', 'Imported Record 0131', 'Pakistan', 'PK', 'Junior Suite', 3, 'low', 5541, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0132', 'FR', 'France', '9d6216e27059ed3c6f5db3956e620f83d5bb0012e441ebb958cc0ffe887aa368')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:133', @guest_id, 'Guest', 'Imported Record 0132', 'France', 'FR', 'Spa Executive', 5, 'high', 12505, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0133', 'KR', 'South Korea', '9b4563543f50116dfe19a8a4d91bf7f3a512b6c01218b41055a36c70d69042e7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:134', @guest_id, 'Guest', 'Imported Record 0133', 'South Korea', 'KR', 'Suite', 1, 'high', 3068, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0134', 'JP', 'Japan', 'bd94c8bf75faf53044af8c6f89bd5425c4a5698bf365390616fc131b8a0d6f92')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:135', @guest_id, 'Guest', 'Imported Record 0134', 'Japan', 'JP', 'Spa Executive', 6, 'mid', 13290, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0135', 'VN', 'Vietnam', '433e10828cd885c72d76dbbc7017ad496190535d55dcf6d263bb73c9bb67bdf2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:136', @guest_id, 'Guest', 'Imported Record 0135', 'Vietnam', 'VN', 'Superior Double', 8, 'high', 15416, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0136', 'CN', 'China', 'da2b6e600d31983c7fa989bb79377d4338a967b6e8d3aec1e9768d90061f3a46')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:137', @guest_id, 'Guest', 'Imported Record 0136', 'China', 'CN', 'Superior Double', 4, 'mid', 7524, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0137', 'US', 'United States', '1b24935376b1b7bc706bc9d69c5162a8cfb9d4ef6f960c9cf25d439537a47d6c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:138', @guest_id, 'Guest', 'Imported Record 0137', 'United States', 'US', 'Spa Executive', 1, 'high', 2606, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0138', 'GB', 'United Kingdom', '866e63be38fad9a111e2bad84d59dbea73b9802c2ae08c2a21146862106a03eb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:139', @guest_id, 'Guest', 'Imported Record 0138', 'United Kingdom', 'GB', 'Spa Executive', 6, 'mid', 14238, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0139', 'RU', 'Russia', '8e59d15c4d1801f8c84951ec85b279265ca02df458f4573f3bf6adaa9b49ce63')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:140', @guest_id, 'Guest', 'Imported Record 0139', 'Russia', 'RU', 'Grand Lit', 10, 'high', 14200, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0140', 'KR', 'South Korea', '1dc24f2456785a21607e9c4d45522ab910c411e889eae2a5bbbeb47c83a1934b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:141', @guest_id, 'Guest', 'Imported Record 0140', 'South Korea', 'KR', 'Standard Single', 4, 'high', 5304, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0141', 'JP', 'Japan', '6443be4b1f8c54885874e2a7948326c02984163a1d488a505bb47fb5a6c93630')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:142', @guest_id, 'Guest', 'Imported Record 0141', 'Japan', 'JP', 'Junior Suite', 10, 'low', 19980, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0142', 'SE', 'Sweden', '1e4b9498b5ab52d4a8cf56e3fdf369b45a7d17fddfab6fe542b649b8e7ec6998')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:143', @guest_id, 'Guest', 'Imported Record 0142', 'Sweden', 'SE', 'Standard Double', 8, 'high', 13480, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0143', 'US', 'United States', '69c01da5cd7c9003baeb018389e1b734b4355e933ae7adbbc0fb07ffc4c12fa3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:144', @guest_id, 'Guest', 'Imported Record 0143', 'United States', 'US', 'LOFT Suite', 8, 'low', 24816, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0144', 'CN', 'China', 'e446d635449df67893675bc4f5ea4fca263df68ce510a3fbca044aa0b24fa32b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:145', @guest_id, 'Guest', 'Imported Record 0144', 'China', 'CN', 'Spa Executive', 6, 'low', 14874, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0145', 'IT', 'Italy', 'b1e008e1637b2879a42bec8dceed0492bef43b2972a6fe6e2e2078307f9aeb26')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:146', @guest_id, 'Guest', 'Imported Record 0145', 'Italy', 'IT', 'Standard Double', 2, 'mid', 3208, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0146', 'IT', 'Italy', '37ecb0656f85a8e4b8cf843ccd1263aede16fdf67d9313b172fec0194f3af048')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:147', @guest_id, 'Guest', 'Imported Record 0146', 'Italy', 'IT', 'Standard Single', 2, 'low', 2144, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0147', 'CA', 'Canada', '77a01376668d0fe9ceaab37167a3aafc1eeaa2c3532db560796ff8f27dd32fe6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:148', @guest_id, 'Guest', 'Imported Record 0147', 'Canada', 'CA', 'Grand Lit', 1, 'mid', 1391, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0148', 'CN', 'China', '1bfe4e9d70e4f78e028870a04c9fb72e21efabb4ed18ff1e3274b7a2d4ceb065')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:149', @guest_id, 'Guest', 'Imported Record 0148', 'China', 'CN', 'Junior Suite', 7, 'low', 13293, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0149', 'AU', 'Australia', 'f6288177eec2c5348db8b2e5476aecceec7931f3fb111e96f13c73a6eb52cfc8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:150', @guest_id, 'Guest', 'Imported Record 0149', 'Australia', 'AU', 'Spa Executive', 2, 'low', 4364, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0150', 'VN', 'Vietnam', '3b61a02bdeb9f69072baa474fec07e324091965de885f908ed9be08b13f80d0d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:151', @guest_id, 'Guest', 'Imported Record 0150', 'Vietnam', 'VN', 'Spa Executive', 1, 'high', 2606, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0151', 'MX', 'Mexico', '457284cf408a4acd8022045eeee62b2c17d7b280f65c62377a81176986cb58d2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:152', @guest_id, 'Guest', 'Imported Record 0151', 'Mexico', 'MX', 'Standard Double', 6, 'low', 7782, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0152', 'BR', 'Brazil', '048e4114008e33d590475ad719bc1121d93add9c614311de810158fb15985fed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:153', @guest_id, 'Guest', 'Imported Record 0152', 'Brazil', 'BR', 'Superior Double', 3, 'low', 5100, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0153', 'KR', 'South Korea', '30187df0ab3b176e61b8e57e5cf2efda91feab70bd69269a82630860d0bda2ac')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:154', @guest_id, 'Guest', 'Imported Record 0153', 'South Korea', 'KR', 'Suite', 8, 'low', 21296, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0154', 'IN', 'India', 'b3720aa3c89a21b93039de14a6a703220d178d7eb96c5bc187a4352f67e957cb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:155', @guest_id, 'Guest', 'Imported Record 0154', 'India', 'IN', 'LOFT Suite', 3, 'mid', 9867, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0155', 'EG', 'Egypt', '77c0c8600f7d00dafea425fc496db53afb2c4f886f9e87b4601cad1668f7790d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:156', @guest_id, 'Guest', 'Imported Record 0155', 'Egypt', 'EG', 'Suite', 5, 'mid', 15415, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0156', 'AU', 'Australia', '0f48aa6fc35949f8da02fadb9d55b462d1d29aa5ae6131b6639fee44ce6dc9c2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:157', @guest_id, 'Guest', 'Imported Record 0156', 'Australia', 'AU', 'Spa Executive', 10, 'high', 26210, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0157', 'IT', 'Italy', '930f393481dcca7700befd8d3433fba3c2b86b510ad67e83728e3a0d2004e4a6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:158', @guest_id, 'Guest', 'Imported Record 0157', 'Italy', 'IT', 'LOFT Suite', 2, 'low', 6830, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0158', 'US', 'United States', 'c47a5a820ce2f4a1e4d6e3585cd1b8e218f1acb6a7f1abf1cdea0dd499a4e034')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:159', @guest_id, 'Guest', 'Imported Record 0158', 'United States', 'US', 'Grand Lit', 1, 'low', 1122, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0159', 'CN', 'China', '017cf195b727ca15734eae1c1a2e18ee8b82ad0217e1dd102a3e58165c9b4063')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:160', @guest_id, 'Guest', 'Imported Record 0159', 'China', 'CN', 'Suite', 9, 'high', 28359, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0160', 'VN', 'Vietnam', '44f8bb83dfc4dec8fd2af8c1709dd99251451d43add68d950f570aa022f48c35')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:161', @guest_id, 'Guest', 'Imported Record 0160', 'Vietnam', 'VN', 'Suite', 3, 'mid', 8454, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0161', 'KR', 'South Korea', '6e87c9d8ed2b65caa00eeb010103ce515bc1ba74e78a9603840c2d5bdbda7486')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:162', @guest_id, 'Guest', 'Imported Record 0161', 'South Korea', 'KR', 'Spa Executive', 8, 'low', 16776, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0162', 'BR', 'Brazil', '06270762142ecfa3ed8655a8881a4a1fd6caaf3724d33c0ffde7c7f123b40d1b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:163', @guest_id, 'Guest', 'Imported Record 0162', 'Brazil', 'BR', 'Spa Executive', 8, 'low', 19424, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0163', 'SE', 'Sweden', '730267790027b335fe469c13678ab8c5761882f97211605fccd3507f3400af1f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:164', @guest_id, 'Guest', 'Imported Record 0163', 'Sweden', 'SE', 'Superior Double', 7, 'high', 14140, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0164', 'CN', 'China', 'b8fc7e16e0cdc0af9d8973efbd9a073541f292a03ddbeb512355e999adf5eb2b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:165', @guest_id, 'Guest', 'Imported Record 0164', 'China', 'CN', 'Junior Suite', 6, 'high', 13434, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0165', 'NG', 'Nigeria', 'c36ff1a7f65bb7a04b3460e2562ba0f21543574259b21e26f6f24975e89ce508')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:166', @guest_id, 'Guest', 'Imported Record 0165', 'Nigeria', 'NG', 'Standard Single', 5, 'low', 5825, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0166', 'RU', 'Russia', '757ca459bad366d723e468b6a5a1eb2b38caa5071eadcb58e3351b8a75434b9e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:167', @guest_id, 'Guest', 'Imported Record 0166', 'Russia', 'RU', 'Spa Executive', 3, 'high', 7614, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0167', 'ES', 'Spain', '35c0cf99e2980645fd84e466ecf226d3f1138bdf7c864749d3f657a64248d58a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:168', @guest_id, 'Guest', 'Imported Record 0167', 'Spain', 'ES', 'Standard Single', 3, 'low', 3087, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0168', 'EG', 'Egypt', '026f4bcfe1d8dc45bb226f9d82a8cf4b32b70bce94613595adee5b436ecb8f98')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:169', @guest_id, 'Guest', 'Imported Record 0168', 'Egypt', 'EG', 'Standard Single', 8, 'mid', 9792, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0169', 'CN', 'China', '65c97090aae77c56c241f6e86e797533b3e88b357f725e8219d0bec7e5ffe69f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:170', @guest_id, 'Guest', 'Imported Record 0169', 'China', 'CN', 'Standard Single', 7, 'low', 7756, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0170', 'IN', 'India', '15e0743e3f2d52aead007341311d0a6e76b20e3bceb049871225bbef0ed4793b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:171', @guest_id, 'Guest', 'Imported Record 0170', 'India', 'IN', 'Spa Executive', 2, 'high', 5590, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0171', 'ES', 'Spain', '800c6ba51cfe58c70b42750f097414aa07bd1c5de0d104aae5148122538b9096')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:172', @guest_id, 'Guest', 'Imported Record 0171', 'Spain', 'ES', 'Superior Double', 6, 'high', 11538, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0172', 'SE', 'Sweden', 'ff06e817307643cefa5002d2ea0f29fcae2a3ee4d7604a4b92c0e224eedfb92c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:173', @guest_id, 'Guest', 'Imported Record 0172', 'Sweden', 'SE', 'LOFT Suite', 1, 'high', 3654, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0173', 'ES', 'Spain', 'f821516f1026ba5d4d3cffa2a7fb1ff56b76df086367e05e8da5994f422a6772')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:174', @guest_id, 'Guest', 'Imported Record 0173', 'Spain', 'ES', 'Grand Lit', 4, 'high', 5912, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0174', 'JP', 'Japan', '5e189b45b694c27c10a06029a88b7cd041544c78037b1e5d69547242430d0ac8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:175', @guest_id, 'Guest', 'Imported Record 0174', 'Japan', 'JP', 'Grand Lit', 5, 'low', 6580, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0175', 'IN', 'India', '520c5dccce4f9ff8aa389e00db39e355599ce8444106c5367e40b720d1b24b2c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:176', @guest_id, 'Guest', 'Imported Record 0175', 'India', 'IN', 'Standard Double', 1, 'low', 1410, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0176', 'VN', 'Vietnam', 'df89201bf0e570d86cf7a3d210f259e32ae152a945ac660358d11988e969a09b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:177', @guest_id, 'Guest', 'Imported Record 0176', 'Vietnam', 'VN', 'Standard Double', 6, 'high', 11730, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0177', 'CA', 'Canada', '77c33a89c41bbd18caa04e95eb25466b5e114dba9c0b3f73910e06e2f30b45fa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:178', @guest_id, 'Guest', 'Imported Record 0177', 'Canada', 'CA', 'Suite', 1, 'high', 3224, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0178', 'KR', 'South Korea', '407d264bf666f3e63cca3e33101a23ac0680f916617f030df24eb8d3228e897c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:179', @guest_id, 'Guest', 'Imported Record 0178', 'South Korea', 'KR', 'Junior Suite', 7, 'low', 13293, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0179', 'CA', 'Canada', '57e068e368b56204ec454b01a87b11b93a4a45ed13a360967231d7b7eaf5ff2e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:180', @guest_id, 'Guest', 'Imported Record 0179', 'Canada', 'CA', 'Grand Lit', 9, 'high', 16065, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0180', 'PK', 'Pakistan', '99aa6c406844ce242c77d2c1514e88f2c514c2946bbef4e5e647f389142279fc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:181', @guest_id, 'Guest', 'Imported Record 0180', 'Pakistan', 'PK', 'LOFT Suite', 6, 'mid', 19362, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0181', 'BR', 'Brazil', '55673cfa1f6baa3dfe50f60be8bb806d43b0f240172cf5278e968b6962f91d2b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:182', @guest_id, 'Guest', 'Imported Record 0181', 'Brazil', 'BR', 'Grand Lit', 3, 'mid', 4341, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0182', 'VN', 'Vietnam', '51639fc390f8d0b8b4a7ad7b45ed0f696de490ce9223cad46f437a8fab07e304')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:183', @guest_id, 'Guest', 'Imported Record 0182', 'Vietnam', 'VN', 'Junior Suite', 6, 'mid', 12300, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0183', 'DE', 'Germany', '0a70bd9b1c0ccf36e61e2bc208052b3220181a869e189743a34ab98122913a54')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:184', @guest_id, 'Guest', 'Imported Record 0183', 'Germany', 'DE', 'Standard Double', 5, 'mid', 6805, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0184', 'NG', 'Nigeria', '88f004fbe603f0b7c96cffb4f536ff796581ec15c86c1e564cb6788f21d3c47e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:185', @guest_id, 'Guest', 'Imported Record 0184', 'Nigeria', 'NG', 'Standard Single', 7, 'low', 7497, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0185', 'AU', 'Australia', 'de89f0b53a11d166dcb86ef971f8b53da508dc4992be2208cba8af415ba64d24')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:186', @guest_id, 'Guest', 'Imported Record 0185', 'Australia', 'AU', 'Suite', 2, 'low', 5602, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0186', 'GB', 'United Kingdom', '89873d2f50d493d3cf45fc66f91e9b0029ef081fcab44f323103a205e6a98eb3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:187', @guest_id, 'Guest', 'Imported Record 0186', 'United Kingdom', 'GB', 'Suite', 6, 'mid', 17892, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0187', 'GB', 'United Kingdom', '8236e662bab4cc146137e516d5db8078d8e318c4e251eadb7992ef8d161d7896')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:188', @guest_id, 'Guest', 'Imported Record 0187', 'United Kingdom', 'GB', 'Standard Double', 10, 'mid', 14930, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0188', 'AU', 'Australia', '46e310deffa90e96892633b0b229730c06a6bc920f631dd9b97f765182910684')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:189', @guest_id, 'Guest', 'Imported Record 0188', 'Australia', 'AU', 'Junior Suite', 2, 'mid', 4518, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0189', 'IN', 'India', '0239d654ead96042da85890f34476ccfbd1b602b121e76d1cb3b8f51c692da2b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:190', @guest_id, 'Guest', 'Imported Record 0189', 'India', 'IN', 'Suite', 6, 'mid', 18378, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0190', 'CA', 'Canada', '0623d6dfca835054644cb187c3c2225fd8158aaddc1732adea837084ef21166a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:191', @guest_id, 'Guest', 'Imported Record 0190', 'Canada', 'CA', 'Grand Lit', 9, 'high', 13779, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0191', 'FR', 'France', 'a9c945b54a46a53619aafbd738380e949bb0ca315a39bed03cd367cc806d4442')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:192', @guest_id, 'Guest', 'Imported Record 0191', 'France', 'FR', 'Spa Executive', 5, 'mid', 11335, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0192', 'ES', 'Spain', 'fe37ab7dcaed5c09f8f9f17ebe067c5592cf778575fd263bfe704d159ccda30d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:193', @guest_id, 'Guest', 'Imported Record 0192', 'Spain', 'ES', 'Standard Double', 7, 'mid', 9786, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0193', 'US', 'United States', '56318a0975bbf1b38428c1e80707e5eb911974291bbd3d973a447b7248b47955')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:194', @guest_id, 'Guest', 'Imported Record 0193', 'United States', 'US', 'Junior Suite', 9, 'mid', 20187, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0194', 'VN', 'Vietnam', '2ae2ae4202a406eb7f9a47faf5db4e41466d5525f4aefd4dda4978d53e76088f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:195', @guest_id, 'Guest', 'Imported Record 0194', 'Vietnam', 'VN', 'Junior Suite', 2, 'low', 3624, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0195', 'CA', 'Canada', '8065be34b91c3904ed9de988ca7212384ad4191fe0fb0ac50497e8247c5b8da0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:196', @guest_id, 'Guest', 'Imported Record 0195', 'Canada', 'CA', 'Standard Single', 8, 'low', 8400, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0196', 'RU', 'Russia', '31c621a8a0b29b8e190be2c9a895c7ba17cccd5cb4b9214409c4b4daaa5962ba')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:197', @guest_id, 'Guest', 'Imported Record 0196', 'Russia', 'RU', 'Grand Lit', 6, 'high', 8586, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0197', 'MX', 'Mexico', '61ed6bd20daf07408afd5dfe05fea7f0c7815f4dca3354f1d8dd6a7b42c04662')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:198', @guest_id, 'Guest', 'Imported Record 0197', 'Mexico', 'MX', 'Junior Suite', 9, 'low', 17154, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0198', 'FR', 'France', 'cf8270467d00e67a76e2cf321c664b4c16f6398696ae9be8abc2ae9fa002c324')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:199', @guest_id, 'Guest', 'Imported Record 0198', 'France', 'FR', 'LOFT Suite', 5, 'high', 18900, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0199', 'KR', 'South Korea', '222805625e23e016e03d8b8a2d6f68298dd955c0d3638e8076426a26afac2348')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:200', @guest_id, 'Guest', 'Imported Record 0199', 'South Korea', 'KR', 'Superior Double', 8, 'high', 16568, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0200', 'FR', 'France', '9614ed93978b06eeb6c9b3289796382b4f191238aae8779d8a5e8b1027bdb320')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:201', @guest_id, 'Guest', 'Imported Record 0200', 'France', 'FR', 'Superior Double', 4, 'mid', 6676, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0201', 'AU', 'Australia', 'b0da68916553db06103241bd7ba3139e726899141a9025436c32e59264ded5c3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:202', @guest_id, 'Guest', 'Imported Record 0201', 'Australia', 'AU', 'Standard Double', 6, 'low', 7860, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0202', 'IN', 'India', 'ff0f475f866866adcb4aafbcd4ebfc285084bde6218bf8d2f6410a6ea8ff4a95')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:203', @guest_id, 'Guest', 'Imported Record 0202', 'India', 'IN', 'Spa Executive', 5, 'low', 12160, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0203', 'SE', 'Sweden', '36063415cb131db10b706cb3249a43cf27571c3bb71bc519048bd2ba7bf58016')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:204', @guest_id, 'Guest', 'Imported Record 0203', 'Sweden', 'SE', 'Superior Double', 7, 'low', 9870, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0204', 'BR', 'Brazil', '38c46a02bfa9cb964a68816abb0751bf31d5ef21c2cc1a4e7f49e900a9cccd8b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:205', @guest_id, 'Guest', 'Imported Record 0204', 'Brazil', 'BR', 'Spa Executive', 5, 'mid', 12750, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0205', 'CN', 'China', 'f1a3839a7ce48cdbba7186f40ff07708f93ecab83cfedd52a9677fa68e4ea126')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:206', @guest_id, 'Guest', 'Imported Record 0205', 'China', 'CN', 'Standard Double', 3, 'mid', 4077, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0206', 'IN', 'India', 'b33355c5a4640ae8f27c703e274148b781578afb07a7feacd78a946f35f5596e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:207', @guest_id, 'Guest', 'Imported Record 0206', 'India', 'IN', 'Junior Suite', 6, 'high', 14688, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0207', 'GB', 'United Kingdom', 'cf9c92ff7308c332fe0ff6a27f89f5bf6fdaacf95d841031d14c75a27b92b290')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:208', @guest_id, 'Guest', 'Imported Record 0207', 'United Kingdom', 'GB', 'Grand Lit', 1, 'high', 1753, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0208', 'CN', 'China', '14904032a1a68102bc47f4affbd96ae3d08ba64fb72968a2bd0891e4a70a044e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:209', @guest_id, 'Guest', 'Imported Record 0208', 'China', 'CN', 'Grand Lit', 7, 'mid', 9947, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0209', 'AU', 'Australia', '9ffa006ecaa0bc451267d890e03b08440829bdb2ac118a5a6ef4aa449fd5de86')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:210', @guest_id, 'Guest', 'Imported Record 0209', 'Australia', 'AU', 'Standard Single', 10, 'low', 11710, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0210', 'SE', 'Sweden', 'f8cd6b6f34ce283b38bcf352b5e4e026f29ad4db9da081f567ec1df86160c122')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:211', @guest_id, 'Guest', 'Imported Record 0210', 'Sweden', 'SE', 'Grand Lit', 6, 'mid', 9534, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0211', 'BR', 'Brazil', 'c658f2322f0b8483d3458f714354e503f76a554a1015a0d1cad0d644ea863650')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:212', @guest_id, 'Guest', 'Imported Record 0211', 'Brazil', 'BR', 'Grand Lit', 6, 'mid', 8400, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0212', 'CN', 'China', '0f8141925e562147e70a18c9eb2d4f5d86a30030a676a91bcaaaed602f590e55')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:213', @guest_id, 'Guest', 'Imported Record 0212', 'China', 'CN', 'Junior Suite', 6, 'mid', 12792, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0213', 'AU', 'Australia', '6241bbff2726d11d60f6bfd9160d48fbaa15cb62f61645641a86a41b8c22c27c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:214', @guest_id, 'Guest', 'Imported Record 0213', 'Australia', 'AU', 'Grand Lit', 10, 'high', 17150, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0214', 'GB', 'United Kingdom', '02097c527094317d44da27fcbe1b59bae7ed290ed3231989075105e077c27d5c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:215', @guest_id, 'Guest', 'Imported Record 0214', 'United Kingdom', 'GB', 'Superior Double', 7, 'low', 11256, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0215', 'GB', 'United Kingdom', '7c467c59e35ee4cbc4235a8167029938a44cd3f524f511cf47ba4cc7ab10e80e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:216', @guest_id, 'Guest', 'Imported Record 0215', 'United Kingdom', 'GB', 'Superior Double', 5, 'high', 10635, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0216', 'ES', 'Spain', 'e150ea44c909c08ae83cd1c282addd4beaf2ae01244bf1f83788167d81d2c3b2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:217', @guest_id, 'Guest', 'Imported Record 0216', 'Spain', 'ES', 'Superior Double', 4, 'mid', 6112, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0217', 'GB', 'United Kingdom', '2a93c258a46cd2de17973af3968a355ffd6f655cfe350e13f567b80c9bb71607')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:218', @guest_id, 'Guest', 'Imported Record 0217', 'United Kingdom', 'GB', 'Standard Double', 10, 'mid', 15770, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0218', 'CN', 'China', '62e9a8d83b60ed77c636add5177f37cd8934d59a3ef0f48d5c08ed15b22dd31f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:219', @guest_id, 'Guest', 'Imported Record 0218', 'China', 'CN', 'Standard Double', 3, 'mid', 4800, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0219', 'VN', 'Vietnam', 'bf96db17ab50ca5061e11c2d3cea5d2400675d94d6bc2b00e394bc24c870bf7c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:220', @guest_id, 'Guest', 'Imported Record 0219', 'Vietnam', 'VN', 'Standard Single', 2, 'high', 2444, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0220', 'JP', 'Japan', '18884289e21cda74b583ab9df8b4fe5005deaac4939745333d45235035aaaebe')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:221', @guest_id, 'Guest', 'Imported Record 0220', 'Japan', 'JP', 'Grand Lit', 7, 'low', 8099, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0221', 'KR', 'South Korea', '628fde601341b805ae8c4c7358fc805df163379cde34dc6338ff59d9ec0e2e75')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:222', @guest_id, 'Guest', 'Imported Record 0221', 'South Korea', 'KR', 'Grand Lit', 5, 'high', 8170, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0222', 'EG', 'Egypt', 'd1b3bd0d31d10102f2612163f8b31b2630c6e774a9afd304ce9649ee7474aaa3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:223', @guest_id, 'Guest', 'Imported Record 0222', 'Egypt', 'EG', 'Standard Double', 6, 'low', 8832, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0223', 'BR', 'Brazil', '05ce3dfffd6d1cd00d1d14d2165bdadaf9fe32f1a8aa4e53f0f38c796907660a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:224', @guest_id, 'Guest', 'Imported Record 0223', 'Brazil', 'BR', 'Standard Single', 10, 'low', 9320, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0224', 'CA', 'Canada', '6ed867216729e529316d0d56517473fa6570d8cb9809737a443ca459890847bb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:225', @guest_id, 'Guest', 'Imported Record 0224', 'Canada', 'CA', 'Junior Suite', 6, 'high', 13272, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0225', 'ES', 'Spain', 'd31d379b359bd6ba721dabc89d68dd996256390914fb041193b2f25a3112cbd9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:226', @guest_id, 'Guest', 'Imported Record 0225', 'Spain', 'ES', 'Standard Single', 1, 'mid', 1038, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0226', 'CA', 'Canada', 'd1f9706c66215a0aa663b8d812d560a1aa5c77fc7a299d660012b06d76e955e5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:227', @guest_id, 'Guest', 'Imported Record 0226', 'Canada', 'CA', 'LOFT Suite', 7, 'high', 26292, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0227', 'AU', 'Australia', 'd181542b3b752de92ede1be4f58f0e00b4b1eed40cb15233485840bec2fc2716')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:228', @guest_id, 'Guest', 'Imported Record 0227', 'Australia', 'AU', 'Standard Single', 4, 'high', 4852, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0228', 'FR', 'France', '267773e1e9dc7d7a8de511ae63777ac8c2dcb9dfd45ee5c14516ccd1427017a9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:229', @guest_id, 'Guest', 'Imported Record 0228', 'France', 'FR', 'Superior Double', 1, 'mid', 1939, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0229', 'PK', 'Pakistan', 'e533defada77effbce730c44911dfc79da8978f3c22627dbd7fe4136deefea9f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:230', @guest_id, 'Guest', 'Imported Record 0229', 'Pakistan', 'PK', 'Standard Double', 1, 'high', 1759, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0230', 'SE', 'Sweden', '36583271bfc9b4014576b4bfe82cb7580e548200f71c9cd1bf1f9302c70daaab')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:231', @guest_id, 'Guest', 'Imported Record 0230', 'Sweden', 'SE', 'Suite', 8, 'low', 23560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0231', 'IT', 'Italy', 'a16b8e06f4354062136357a63650feadbcfd9126eb2f9f5d4eeab6fcaaa1dd57')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:232', @guest_id, 'Guest', 'Imported Record 0231', 'Italy', 'IT', 'Superior Double', 6, 'low', 8922, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0232', 'KR', 'South Korea', 'b445b33ab6cde2594e8acc530a8f9fe7d92a708199bfb9b7346aa873975ab0fa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:233', @guest_id, 'Guest', 'Imported Record 0232', 'South Korea', 'KR', 'Junior Suite', 4, 'low', 7464, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0233', 'PK', 'Pakistan', 'cee95e42097284a8787efbf43f07dd5883eaaa0656d94c35c9ffc07f248f69a8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:234', @guest_id, 'Guest', 'Imported Record 0233', 'Pakistan', 'PK', 'Grand Lit', 2, 'low', 2686, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0234', 'FR', 'France', '44628ee29178064713fe94a0838de3586919de5a9f81ed5f5b8e15426ca02dda')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:235', @guest_id, 'Guest', 'Imported Record 0234', 'France', 'FR', 'Standard Double', 1, 'low', 1483, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0235', 'KR', 'South Korea', 'a5d2c513bb1d7a1bbce62ab52a897a3ad0b09eeadfdaf98eb8fa30bda65d7528')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:236', @guest_id, 'Guest', 'Imported Record 0235', 'South Korea', 'KR', 'Grand Lit', 2, 'low', 2760, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0236', 'SE', 'Sweden', 'fbe68b9841f2290ca5c9aa9b46cee74646a8ca16802353164a781681606c3626')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:237', @guest_id, 'Guest', 'Imported Record 0236', 'Sweden', 'SE', 'Spa Executive', 9, 'high', 25038, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0237', 'RU', 'Russia', 'f63cbb5fac09afa489290c56a22ebccb80ae4127d4684f3b81e45e2b3affcab5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:238', @guest_id, 'Guest', 'Imported Record 0237', 'Russia', 'RU', 'Standard Double', 9, 'high', 15003, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0238', 'FR', 'France', '30f2f9a129c79ffc2f1f0d0fe0a63c4401d1a191acbb82fe0bf68425db812b94')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:239', @guest_id, 'Guest', 'Imported Record 0238', 'France', 'FR', 'Suite', 5, 'high', 16080, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0239', 'EG', 'Egypt', 'c3bf74338f99f269b08bb009519283aaf31c55d01ef72b6e7dc5161cba76e01b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:240', @guest_id, 'Guest', 'Imported Record 0239', 'Egypt', 'EG', 'Spa Executive', 8, 'high', 21440, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0240', 'KR', 'South Korea', '066368c645ffc2ce6ff663e7bf828dda778bd9675f7efc34fed383ff82c756f0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:241', @guest_id, 'Guest', 'Imported Record 0240', 'South Korea', 'KR', 'Junior Suite', 7, 'low', 14329, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0241', 'MX', 'Mexico', 'b2662b06fb7fe6122f9ccd4d804303030c1b648585ebe51dd237e4235cf72334')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:242', @guest_id, 'Guest', 'Imported Record 0241', 'Mexico', 'MX', 'Superior Double', 2, 'mid', 3768, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0242', 'NG', 'Nigeria', '5220f18147624cd51ad7888c483f3197cabfd45a76817dd49a6a191d4663d198')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:243', @guest_id, 'Guest', 'Imported Record 0242', 'Nigeria', 'NG', 'Superior Double', 10, 'low', 17490, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0243', 'CN', 'China', '217e04a7fc30ee9fe234ccce24178ec4cbdaefd7c5378f3f462ca2e4443f8c4a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:244', @guest_id, 'Guest', 'Imported Record 0243', 'China', 'CN', 'LOFT Suite', 10, 'low', 33860, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0244', 'KR', 'South Korea', '79101afe554f6e2d5ca87c18527d0e73e436f13481e712d921b143f08d8f0f62')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:245', @guest_id, 'Guest', 'Imported Record 0244', 'South Korea', 'KR', 'Standard Double', 5, 'mid', 8075, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0245', 'BR', 'Brazil', 'f8b94858797a92bafa56ad39a375436fa4d0271f616d00f706ef2b4ea25ce29a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:246', @guest_id, 'Guest', 'Imported Record 0245', 'Brazil', 'BR', 'Suite', 6, 'mid', 19446, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0246', 'IN', 'India', '26af6613bbdf72998836d7f7c01bc32e37344837ad3e3cde40a3e224c8fc9ba8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:247', @guest_id, 'Guest', 'Imported Record 0246', 'India', 'IN', 'Suite', 1, 'high', 3083, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0247', 'NG', 'Nigeria', '1b0c66809bc6bb06df9e0f6b53e57aecf78947f23fb21075304b9ad8151453c4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:248', @guest_id, 'Guest', 'Imported Record 0247', 'Nigeria', 'NG', 'Standard Double', 6, 'high', 10968, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0248', 'MX', 'Mexico', '8091993e683c5eae3f8bfb2fe25333c89ea40eda69b0ff03af991a7a258361ef')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:249', @guest_id, 'Guest', 'Imported Record 0248', 'Mexico', 'MX', 'Spa Executive', 3, 'mid', 7341, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0249', 'IN', 'India', '680db430fca1684ed86f16e4d379b2bf77589625c6c39c0408f74b91cf715238')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:250', @guest_id, 'Guest', 'Imported Record 0249', 'India', 'IN', 'Standard Single', 7, 'mid', 8960, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0250', 'DE', 'Germany', 'ec62b2f61c1b648a830bf5f366d47e2a10b4964da226f85004859cbaaf4c0214')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:251', @guest_id, 'Guest', 'Imported Record 0250', 'Germany', 'DE', 'Suite', 4, 'mid', 12984, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0251', 'SE', 'Sweden', '1a587e0c9af39dee0dce3ce73fe1edba33f84e088814098f1d5bdc537f16f69e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:252', @guest_id, 'Guest', 'Imported Record 0251', 'Sweden', 'SE', 'Spa Executive', 1, 'low', 2297, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0252', 'IT', 'Italy', 'aa641bf401fba42beaafa690404b589a7982b6453db810ebe987d59bd1f7573c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:253', @guest_id, 'Guest', 'Imported Record 0252', 'Italy', 'IT', 'Grand Lit', 4, 'low', 4452, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0253', 'IN', 'India', '683c2de0a64c764e3a5cd37162779f18d545ea74173458465063ba87ceb299fd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:254', @guest_id, 'Guest', 'Imported Record 0253', 'India', 'IN', 'Superior Double', 2, 'low', 2866, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0254', 'AU', 'Australia', '40a8a14409baf2422b5b3e72a59773ab8af743e8df7f615396f7bb73b8ebffd9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:255', @guest_id, 'Guest', 'Imported Record 0254', 'Australia', 'AU', 'Standard Double', 9, 'low', 14139, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0255', 'BR', 'Brazil', '4eed133b3492f108548ea17d32c6068a6f82e203bfd80e73941dba55d20ca228')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:256', @guest_id, 'Guest', 'Imported Record 0255', 'Brazil', 'BR', 'Suite', 1, 'mid', 2989, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0256', 'IT', 'Italy', '469065ca27dd6ac0265863d2431a9d71b1541102e438a9f7234228729f73e301')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:257', @guest_id, 'Guest', 'Imported Record 0256', 'Italy', 'IT', 'Superior Double', 2, 'mid', 3780, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0257', 'DE', 'Germany', '5a6b279427081cceae41532298c9eb1026d24ef9cf9389f5a37420ab056a3e21')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:258', @guest_id, 'Guest', 'Imported Record 0257', 'Germany', 'DE', 'Grand Lit', 9, 'low', 10917, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0258', 'FR', 'France', 'f71e1a9672bb214e90e2c5102ca1e31ab98437a7e620ece37cd50786740f8d08')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:259', @guest_id, 'Guest', 'Imported Record 0258', 'France', 'FR', 'Superior Double', 1, 'low', 1736, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0259', 'EG', 'Egypt', '12eaee6b98c79eff43d36a60b0a0219fe64c7462f1a31f257a48f7c3383ad8f1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:260', @guest_id, 'Guest', 'Imported Record 0259', 'Egypt', 'EG', 'Suite', 1, 'low', 2849, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0260', 'IT', 'Italy', '7f251f84c3e7d459209131402df997d2facc917a0062eb0807cb6601a66b585b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:261', @guest_id, 'Guest', 'Imported Record 0260', 'Italy', 'IT', 'Spa Executive', 5, 'low', 12085, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0261', 'NG', 'Nigeria', '8f862063f055e5c434cb8a20ac240e291d8b8f702c37563259d5e9ec04261d57')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:262', @guest_id, 'Guest', 'Imported Record 0261', 'Nigeria', 'NG', 'LOFT Suite', 6, 'low', 18630, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0262', 'RU', 'Russia', '5b80fbaa8c970a54dc955a0f5236929bdce4ecf896a6a1a50685877b080d86ae')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:263', @guest_id, 'Guest', 'Imported Record 0262', 'Russia', 'RU', 'Superior Double', 8, 'high', 17376, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0263', 'GB', 'United Kingdom', 'd8fd96500843781d661b95eecb55da323784eb0c2657b8fca1f9dd8e47e3c764')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:264', @guest_id, 'Guest', 'Imported Record 0263', 'United Kingdom', 'GB', 'Grand Lit', 8, 'mid', 9784, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0264', 'RU', 'Russia', 'c2086e2fed5dd1fd96517a09213f5f9f4ddf191059e0b01c15cc1ed5f0ded6e3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:265', @guest_id, 'Guest', 'Imported Record 0264', 'Russia', 'RU', 'Spa Executive', 4, 'mid', 10000, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0265', 'BR', 'Brazil', '95541d3aa9ed07b46e532017b56400629518d0924c41092df026ecb317964d94')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:266', @guest_id, 'Guest', 'Imported Record 0265', 'Brazil', 'BR', 'LOFT Suite', 3, 'mid', 10170, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0266', 'IN', 'India', 'c0533a341d4710adf87dd347ac4ad6c9fd1fe6da80bdae69edcec73455d69fa0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:267', @guest_id, 'Guest', 'Imported Record 0266', 'India', 'IN', 'Suite', 9, 'mid', 27297, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0267', 'MX', 'Mexico', '447abeb5fcaf000544e95edb6ce0d802c48f8db0a0a2901b580ac652fe1055af')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:268', @guest_id, 'Guest', 'Imported Record 0267', 'Mexico', 'MX', 'Superior Double', 8, 'low', 12592, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0268', 'MX', 'Mexico', '6842126cfd6050e75355ebda438acdf864270e046260009e4c0fa9ff9d888854')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:269', @guest_id, 'Guest', 'Imported Record 0268', 'Mexico', 'MX', 'Superior Double', 6, 'mid', 11142, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0269', 'GB', 'United Kingdom', 'b9a1ec3f21d4f76e26a4602526dece4323fd5e183b8f189f04d72ac46ae5cc19')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:270', @guest_id, 'Guest', 'Imported Record 0269', 'United Kingdom', 'GB', 'Superior Double', 4, 'mid', 7732, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0270', 'RU', 'Russia', '244b4ed5f0593e8851a1dc9e5bf61f52ba3ee8cfbd169ce66d53c3542db57fd2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:271', @guest_id, 'Guest', 'Imported Record 0270', 'Russia', 'RU', 'Junior Suite', 5, 'high', 12465, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0271', 'MX', 'Mexico', 'b3583c69bc6203acd640675059d0f6decd944ee56f466b8e5e54f11b771a526c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:272', @guest_id, 'Guest', 'Imported Record 0271', 'Mexico', 'MX', 'Spa Executive', 5, 'low', 11005, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0272', 'US', 'United States', 'e588a37018b7da0f18787924865eb3640aa9a327c3b3df1946c932f832c1cbeb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:273', @guest_id, 'Guest', 'Imported Record 0272', 'United States', 'US', 'LOFT Suite', 2, 'high', 7452, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0273', 'MX', 'Mexico', '583d88bab89ecf5bad50c0827fd227b444e2a7a360c8c5e2538675cfbbcddb11')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:274', @guest_id, 'Guest', 'Imported Record 0273', 'Mexico', 'MX', 'Superior Double', 9, 'high', 19332, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0274', 'PK', 'Pakistan', '83b2c6333a04ca83c78dff650cc0eafd23c3484792fe591ed9c343e7a04ae4d3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:275', @guest_id, 'Guest', 'Imported Record 0274', 'Pakistan', 'PK', 'Spa Executive', 3, 'low', 6630, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0275', 'VN', 'Vietnam', '6ae6a4c01066add5e4a794bacb1a97bd684f990d475f4e48234b7523c1be4caa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:276', @guest_id, 'Guest', 'Imported Record 0275', 'Vietnam', 'VN', 'Standard Double', 8, 'low', 11776, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0276', 'GB', 'United Kingdom', '2fe40af7233a8c45f277d4ba66a4d3147b4ae742a01666770b148bd787398183')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:277', @guest_id, 'Guest', 'Imported Record 0276', 'United Kingdom', 'GB', 'Standard Double', 10, 'low', 15860, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0277', 'CA', 'Canada', 'd36a8f5ca3bfa622726ab6d34478a78bfa783c82bd1ddf2a103bde167acbaf4e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:278', @guest_id, 'Guest', 'Imported Record 0277', 'Canada', 'CA', 'Junior Suite', 2, 'mid', 4470, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0278', 'IT', 'Italy', '10bcd8a22e241e400f9df2bf6a33318ae85322fbfd5403df20dae0ea1fbe0b9d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:279', @guest_id, 'Guest', 'Imported Record 0278', 'Italy', 'IT', 'Suite', 8, 'mid', 23112, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0279', 'EG', 'Egypt', 'c049045da218aa1238687c9fd7c8b516f6c7787039226d723e41f79f82f881b9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:280', @guest_id, 'Guest', 'Imported Record 0279', 'Egypt', 'EG', 'Standard Double', 10, 'low', 15740, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0280', 'KR', 'South Korea', '0208ac05b7aea1815477d25dcf4e440b24f41eac5a522b1db1685c34b34168aa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:281', @guest_id, 'Guest', 'Imported Record 0280', 'South Korea', 'KR', 'LOFT Suite', 3, 'low', 9507, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0281', 'FR', 'France', '49d0e4a1a360ef0426d2247493e7c5f3c595dd40255602a6de653b5b8f13e082')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:282', @guest_id, 'Guest', 'Imported Record 0281', 'France', 'FR', 'Grand Lit', 10, 'mid', 12290, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0282', 'CN', 'China', '0cf034d1d14b67c1b109fec036dd7463fa77b046f1ec3294e88d9443e8130d20')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:283', @guest_id, 'Guest', 'Imported Record 0282', 'China', 'CN', 'Junior Suite', 10, 'high', 24910, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0283', 'AU', 'Australia', '02a1db007e112e6a8f6de71fd53a88b104ab65745a1e5a1949cd808d5f522887')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:284', @guest_id, 'Guest', 'Imported Record 0283', 'Australia', 'AU', 'Standard Single', 3, 'mid', 3675, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0284', 'CA', 'Canada', 'a87fba3f5eeb9b04833cd1527e52a546dcb5580b2ccbc093c645759bb5f6525f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:285', @guest_id, 'Guest', 'Imported Record 0284', 'Canada', 'CA', 'Standard Double', 8, 'low', 11928, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0285', 'ES', 'Spain', '4bac08c6cb35624d0ddc801f109660429bac5dda3dcfc234042b79fca0fb847a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:286', @guest_id, 'Guest', 'Imported Record 0285', 'Spain', 'ES', 'Spa Executive', 10, 'high', 25350, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0286', 'ES', 'Spain', '4d77cf525c5f461b428c73ead98a16e66deaf3c22a87709ba61ef1e626c55c28')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:287', @guest_id, 'Guest', 'Imported Record 0286', 'Spain', 'ES', 'Junior Suite', 4, 'mid', 9324, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0287', 'IN', 'India', '70ea339661e6d5e2d55152fb4d73c65d38832998edcfbd0035f2682910d6cedf')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:288', @guest_id, 'Guest', 'Imported Record 0287', 'India', 'IN', 'Junior Suite', 3, 'low', 5772, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0288', 'IT', 'Italy', '4f75a6cc4b9a5e66308708310957f07f05349ba71526a9289429da367fa6d247')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:289', @guest_id, 'Guest', 'Imported Record 0288', 'Italy', 'IT', 'Superior Double', 10, 'low', 17510, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0289', 'VN', 'Vietnam', '5d3300dfeec33f0dd493ebea90c2f007bae35416ae8c34f79573b227294484a2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:290', @guest_id, 'Guest', 'Imported Record 0289', 'Vietnam', 'VN', 'Grand Lit', 9, 'high', 15435, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0290', 'BR', 'Brazil', '6acaa6eb04b7eecc1bcf35238218af008cecd8f08f380a214ff0a2e550f1a872')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:291', @guest_id, 'Guest', 'Imported Record 0290', 'Brazil', 'BR', 'Standard Single', 10, 'mid', 11340, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0291', 'MX', 'Mexico', '174eb82c94293ab9e4480d157a8e82ddbc68afdba3c7e11cfa8a5325af5b632c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:292', @guest_id, 'Guest', 'Imported Record 0291', 'Mexico', 'MX', 'Standard Single', 9, 'high', 12015, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0292', 'BR', 'Brazil', 'f61fc70eee8853f82557d1873e40031d07944192b8071e81275c069b1388fd64')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:293', @guest_id, 'Guest', 'Imported Record 0292', 'Brazil', 'BR', 'Junior Suite', 6, 'high', 13620, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0293', 'NG', 'Nigeria', '661180669d312585b5096b98005fb40aed1d4d4e997bac6954eb171170609bee')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:294', @guest_id, 'Guest', 'Imported Record 0293', 'Nigeria', 'NG', 'Junior Suite', 7, 'low', 13860, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0294', 'AU', 'Australia', '03c3cde9e7a38196d625569abf285d3fa79b0c780f2335a55fe5e43a5b274ed5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:295', @guest_id, 'Guest', 'Imported Record 0294', 'Australia', 'AU', 'Superior Double', 1, 'high', 2098, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0295', 'IT', 'Italy', '139791c2fe8c41f5b04e7f9e93298ceeeeec6f2ee5db7c85fe92b2a502373e64')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:296', @guest_id, 'Guest', 'Imported Record 0295', 'Italy', 'IT', 'Standard Single', 6, 'mid', 7320, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0296', 'DE', 'Germany', 'ee917cc49e435b25398060c93410c427aa6c05d64448846281a57333ae27148e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:297', @guest_id, 'Guest', 'Imported Record 0296', 'Germany', 'DE', 'LOFT Suite', 5, 'high', 18565, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0297', 'NG', 'Nigeria', 'ae47e7bdc0a388a9ea4674b22f23e7f595ca2b0351be822b6d2253b8ec750f59')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:298', @guest_id, 'Guest', 'Imported Record 0297', 'Nigeria', 'NG', 'Standard Single', 2, 'low', 1958, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0298', 'IN', 'India', '4450549b81fbf81a4e476ec72577febb377965628758375cecb106a7e9330509')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:299', @guest_id, 'Guest', 'Imported Record 0298', 'India', 'IN', 'Grand Lit', 4, 'mid', 5580, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0299', 'FR', 'France', 'edb731712a9416947f2240c7e534398c71d058b432d2e424ac4eda2d6c369d49')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:300', @guest_id, 'Guest', 'Imported Record 0299', 'France', 'FR', 'Superior Double', 10, 'high', 18750, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0300', 'US', 'United States', 'bdc0c879eda1c45c44192336340b15970cb134f0edad05439b052cc5347747cb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:301', @guest_id, 'Guest', 'Imported Record 0300', 'United States', 'US', 'Superior Double', 9, 'high', 16524, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0301', 'GB', 'United Kingdom', 'edc39362abf3880a0fcfd6d0322f87d1aee0648c1714b9841ba0dd34a5cc13f9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:302', @guest_id, 'Guest', 'Imported Record 0301', 'United Kingdom', 'GB', 'Superior Double', 2, 'mid', 3036, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0302', 'GB', 'United Kingdom', '65ea57e873e949637699aa56cf78a961d58ce9da772a658e7a531ea852c2692a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:303', @guest_id, 'Guest', 'Imported Record 0302', 'United Kingdom', 'GB', 'Junior Suite', 6, 'high', 14790, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0303', 'JP', 'Japan', '1d7ccbb68e49d99d9d8cc946dfde62381f58ddab6851acb38708609d4e65ae65')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:304', @guest_id, 'Guest', 'Imported Record 0303', 'Japan', 'JP', 'Junior Suite', 10, 'mid', 20640, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0304', 'EG', 'Egypt', 'c99c1788dfa7f006c3b379d6eb63dd6e5a9f6f7011d16cd15c5888ea3cfa0667')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:305', @guest_id, 'Guest', 'Imported Record 0304', 'Egypt', 'EG', 'Suite', 8, 'low', 20072, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0305', 'JP', 'Japan', '3d08f79397ffcc53f2c24664a0f5418daae26fa102f22ba054d74601c15e7ad6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:306', @guest_id, 'Guest', 'Imported Record 0305', 'Japan', 'JP', 'Standard Double', 4, 'high', 6520, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0306', 'JP', 'Japan', '9476ccbfceef9f0749fedb4a5c60c3c5427c20cc12dbf4faa1c87a382c7f0354')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:307', @guest_id, 'Guest', 'Imported Record 0306', 'Japan', 'JP', 'Superior Double', 6, 'mid', 9984, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0307', 'CN', 'China', '730feb5251036ec8ed65492473b5547f6f7fd691e203d4083c89e5d8a1908fb5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:308', @guest_id, 'Guest', 'Imported Record 0307', 'China', 'CN', 'Superior Double', 3, 'low', 4344, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0308', 'NG', 'Nigeria', 'cc55a2c22a25a5c6d32c53fd06f25b88604970d489284a49be5a572d7a11199d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:309', @guest_id, 'Guest', 'Imported Record 0308', 'Nigeria', 'NG', 'Grand Lit', 9, 'mid', 12294, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0309', 'ES', 'Spain', '11beacf5103290389f91f35f4da447f6e3ef8e284bbcd0c7dbace40811a8841a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:310', @guest_id, 'Guest', 'Imported Record 0309', 'Spain', 'ES', 'Grand Lit', 4, 'low', 5156, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0310', 'MX', 'Mexico', '79473b0758ed19a55641cd4d73f4df60b6fe0830dd1011f5c05b4edfbda2911a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:311', @guest_id, 'Guest', 'Imported Record 0310', 'Mexico', 'MX', 'Grand Lit', 1, 'mid', 1564, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0311', 'PK', 'Pakistan', '79a15493f4ee7011cc13de00e670600b5ef2e69003cd67abcaef4627bfb31908')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:312', @guest_id, 'Guest', 'Imported Record 0311', 'Pakistan', 'PK', 'LOFT Suite', 7, 'high', 25550, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0312', 'CN', 'China', '5d148dc29bc75f3a5c009ae93751af087b7f8a252da91f5699192fcdb55c2e00')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:313', @guest_id, 'Guest', 'Imported Record 0312', 'China', 'CN', 'Grand Lit', 10, 'mid', 13930, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0313', 'RU', 'Russia', 'bd3f636a41b283b6b0c18299cf40fd0013c9658d732afd431cb66530c99c9b14')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:314', @guest_id, 'Guest', 'Imported Record 0313', 'Russia', 'RU', 'Spa Executive', 2, 'mid', 4950, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0314', 'CA', 'Canada', 'c93325d436a6c5299ca66af688277ccc7a42191c47d95c8560e164dc1fd4e8e3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:315', @guest_id, 'Guest', 'Imported Record 0314', 'Canada', 'CA', 'Grand Lit', 10, 'high', 17590, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0315', 'AU', 'Australia', 'f24ba4e6587344d50482f679b2beee8a6ba38f62347977b8504f1b0d14ecc480')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:316', @guest_id, 'Guest', 'Imported Record 0315', 'Australia', 'AU', 'LOFT Suite', 6, 'high', 21648, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0316', 'DE', 'Germany', 'd420aa97d9501c6b695a4d629d04fc99fd536002fe25a114683102511565269d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:317', @guest_id, 'Guest', 'Imported Record 0316', 'Germany', 'DE', 'Suite', 9, 'mid', 26604, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0317', 'GB', 'United Kingdom', '82a3ec0a1606364a3673c384f5811ea520dcc294c34812344bf8d75abf5718b8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:318', @guest_id, 'Guest', 'Imported Record 0317', 'United Kingdom', 'GB', 'Superior Double', 2, 'high', 3694, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0318', 'SE', 'Sweden', '5d94cd6a132ba1c82f3f8c9350db680ff51cb256b3a389790afe47a035e8926a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:319', @guest_id, 'Guest', 'Imported Record 0318', 'Sweden', 'SE', 'Suite', 9, 'mid', 24966, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0319', 'JP', 'Japan', '84aed9eb855dce9fb7630f19a61aa472ab28268720a9b0ecd8663a2711d180a5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:320', @guest_id, 'Guest', 'Imported Record 0319', 'Japan', 'JP', 'LOFT Suite', 3, 'low', 9732, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0320', 'KR', 'South Korea', '8b8ed61021e351c2b5247ebbeb54becfc3a80d22ec0498219136cece70237f41')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:321', @guest_id, 'Guest', 'Imported Record 0320', 'South Korea', 'KR', 'Standard Single', 1, 'mid', 1133, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0321', 'US', 'United States', 'b5f98bad82cff5123d21aca20e7009fe38229af16df97b2724d20d1c87b36f0a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:322', @guest_id, 'Guest', 'Imported Record 0321', 'United States', 'US', 'Junior Suite', 5, 'high', 12460, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0322', 'US', 'United States', 'f220245e089019519c7a0b1c64cbec94ef431784f6ed9bfa3c61433ec148ff34')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:323', @guest_id, 'Guest', 'Imported Record 0322', 'United States', 'US', 'Grand Lit', 3, 'high', 4569, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0323', 'DE', 'Germany', 'b72ad41675495d763bd526d5b8f50309ac1bebedebda39fca3c2faba3f01f667')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:324', @guest_id, 'Guest', 'Imported Record 0323', 'Germany', 'DE', 'LOFT Suite', 1, 'high', 3719, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0324', 'DE', 'Germany', '80b6c2c925160257f1d23e667d8d0eeace4a63969340262254d0525d5457603a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:325', @guest_id, 'Guest', 'Imported Record 0324', 'Germany', 'DE', 'Superior Double', 7, 'low', 10423, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0325', 'MX', 'Mexico', '0b0388b4dd1bcd13085285937e430b8a10fd5c3b833d45bd4f826f10571dc54f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:326', @guest_id, 'Guest', 'Imported Record 0325', 'Mexico', 'MX', 'Superior Double', 5, 'low', 8620, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0326', 'BR', 'Brazil', '68b03a5c5f34591584d777f92b5551e92b857d8747482b5b8625ca96f7d87907')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:327', @guest_id, 'Guest', 'Imported Record 0326', 'Brazil', 'BR', 'Superior Double', 7, 'mid', 13076, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0327', 'IT', 'Italy', 'cc178af15e2e2efc4b8a14560adb752d7c2aa0d857909c6d157305f323bdae61')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:328', @guest_id, 'Guest', 'Imported Record 0327', 'Italy', 'IT', 'Standard Single', 10, 'high', 13760, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0328', 'PK', 'Pakistan', 'eebc99c760e5e7ec8e09d0f4064ab491cfc0d3ef9829ed87d31dbd25c7fb34f8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:329', @guest_id, 'Guest', 'Imported Record 0328', 'Pakistan', 'PK', 'Standard Single', 3, 'high', 3942, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0329', 'CN', 'China', '96c6e3ba1084904bc19e6eef62b720319b7c62342bdeeb626c7ebc179b7983a5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:330', @guest_id, 'Guest', 'Imported Record 0329', 'China', 'CN', 'Grand Lit', 2, 'high', 3082, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0330', 'AU', 'Australia', '4080f5039144b5c310d0b0cf7faf338273e8ee5a7bdba4c0c7785af2ad56006b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:331', @guest_id, 'Guest', 'Imported Record 0330', 'Australia', 'AU', 'Standard Double', 10, 'mid', 14490, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0331', 'SE', 'Sweden', '85a49e572b897639d9a6f5ebf85d3071ad9b9426d08218e09af1a75d25d14ce8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:332', @guest_id, 'Guest', 'Imported Record 0331', 'Sweden', 'SE', 'Grand Lit', 6, 'mid', 9006, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0332', 'CA', 'Canada', '3e03659b17d8e0aece71a4efe6c34b7be007e0e21517d4fd555301653d559841')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:333', @guest_id, 'Guest', 'Imported Record 0332', 'Canada', 'CA', 'Standard Single', 8, 'low', 8032, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0333', 'US', 'United States', '850db13ba3e06bed4bc598381f885378f50c3bd53fb0d615bb1f060b297f6b16')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:334', @guest_id, 'Guest', 'Imported Record 0333', 'United States', 'US', 'Grand Lit', 10, 'high', 14170, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0334', 'RU', 'Russia', '68bdad86bb48c134ec4f78df8b138d9af32bf00558a838648ccc0e5beb6e43ed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:335', @guest_id, 'Guest', 'Imported Record 0334', 'Russia', 'RU', 'Suite', 3, 'mid', 9639, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0335', 'PK', 'Pakistan', 'e5e7a19ddc87b8e243ff60a133a3348683ff954c5a0d042ce03bd4590ad9185d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:336', @guest_id, 'Guest', 'Imported Record 0335', 'Pakistan', 'PK', 'LOFT Suite', 3, 'low', 9000, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0336', 'SE', 'Sweden', '8e4dcb4d5c0e9f4087686d2bcc6c42fd3ae007d371939833c800580cc7bdf678')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:337', @guest_id, 'Guest', 'Imported Record 0336', 'Sweden', 'SE', 'Junior Suite', 2, 'high', 4996, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0337', 'CN', 'China', '2f1749bc0096be8d8138611027e918e7f97de247e8872bdde32970397a153234')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:338', @guest_id, 'Guest', 'Imported Record 0337', 'China', 'CN', 'Standard Double', 4, 'mid', 5464, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0338', 'US', 'United States', '2933a70b5396e54da958d1bff886fb79a4d8dbbf290498caff649b72da4c2afd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:339', @guest_id, 'Guest', 'Imported Record 0338', 'United States', 'US', 'Standard Double', 8, 'low', 10528, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0339', 'JP', 'Japan', '26e5644a9688df70e335cb2aa26c5304499b861d1903e595fddcc1b86ea012ef')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:340', @guest_id, 'Guest', 'Imported Record 0339', 'Japan', 'JP', 'LOFT Suite', 3, 'high', 11736, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0340', 'EG', 'Egypt', '6798e3b64e498128246f4fcb58cba32c4e05e3841b184c4ccdf1d8238db2bcec')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:341', @guest_id, 'Guest', 'Imported Record 0340', 'Egypt', 'EG', 'Spa Executive', 7, 'mid', 16562, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0341', 'CN', 'China', '8ebddc7b3ffc4b2d42bf45d39a480d7e205b3305e168c8943d7ffd01f62c1209')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:342', @guest_id, 'Guest', 'Imported Record 0341', 'China', 'CN', 'Standard Single', 1, 'mid', 1159, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0342', 'SE', 'Sweden', '1f038ab576b80791d4bfbc2137750a33434c3c1a2f2ee02d3a6255d594ebe716')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:343', @guest_id, 'Guest', 'Imported Record 0342', 'Sweden', 'SE', 'Standard Single', 6, 'low', 6702, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0343', 'MX', 'Mexico', '60f05fa3e105967b79c3f40e674131376a19cdd42a84de451b27952fa105da63')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:344', @guest_id, 'Guest', 'Imported Record 0343', 'Mexico', 'MX', 'Superior Double', 10, 'high', 20720, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0344', 'IT', 'Italy', '5a90478eaaece8cdc66929a64cbf1bd063421d91f24b07a589623a9aad5ab782')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:345', @guest_id, 'Guest', 'Imported Record 0344', 'Italy', 'IT', 'Spa Executive', 8, 'high', 20976, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0345', 'BR', 'Brazil', '2cc8003fe9a6c99d3eb1b5d8c8656be2f4ce77d713b4c22aa5d7e548579d852a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:346', @guest_id, 'Guest', 'Imported Record 0345', 'Brazil', 'BR', 'Suite', 8, 'high', 24160, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0346', 'VN', 'Vietnam', 'd184c4f3c3b80ca32513698301b85088ca77257276f8c780834fed323ec0ed3d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:347', @guest_id, 'Guest', 'Imported Record 0346', 'Vietnam', 'VN', 'Junior Suite', 1, 'high', 2253, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0347', 'FR', 'France', 'd73e4a58b2e09fb4d556c8c45e22743603d30a5ce6e43e047a8b8bb44559e271')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:348', @guest_id, 'Guest', 'Imported Record 0347', 'France', 'FR', 'Grand Lit', 10, 'high', 17930, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0348', 'JP', 'Japan', 'fddeba2327c5de084221a8396c80993dfd4251c3a7094f43bb60a86219d6ff47')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:349', @guest_id, 'Guest', 'Imported Record 0348', 'Japan', 'JP', 'Superior Double', 10, 'low', 15900, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0349', 'VN', 'Vietnam', '16c0b7b6a594b4fb89af1d16252e40c183f89fecbdd5fac156d767de44ea5434')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:350', @guest_id, 'Guest', 'Imported Record 0349', 'Vietnam', 'VN', 'LOFT Suite', 5, 'low', 16090, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0350', 'CN', 'China', '27f2786ba2a47ae2d9708c0106b52423f5858f02a5ead0d7fba24f6314750d49')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:351', @guest_id, 'Guest', 'Imported Record 0350', 'China', 'CN', 'Spa Executive', 10, 'mid', 22700, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0351', 'JP', 'Japan', '791fa9c4557a80648aa459ce37a6dbd9f7f2500258a6bf7d4103f0bb41443d23')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:352', @guest_id, 'Guest', 'Imported Record 0351', 'Japan', 'JP', 'Standard Single', 6, 'mid', 7146, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0352', 'IN', 'India', 'a090e3c494a8f1988fde909998a7af273bfe2191cf9a9dce8bbb0c2fc50ac899')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:353', @guest_id, 'Guest', 'Imported Record 0352', 'India', 'IN', 'LOFT Suite', 1, 'low', 3225, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0353', 'ES', 'Spain', '5c98aefdd514ccdf118d3b81ff11626ed4dbdd97edd191f0782ca83856b39244')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:354', @guest_id, 'Guest', 'Imported Record 0353', 'Spain', 'ES', 'Suite', 7, 'mid', 20468, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0354', 'PK', 'Pakistan', 'caa36576ec3e119297ad908d9883444fdef871b1e4435ea2b54047fd0aa00508')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:355', @guest_id, 'Guest', 'Imported Record 0354', 'Pakistan', 'PK', 'Junior Suite', 9, 'mid', 18153, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0355', 'JP', 'Japan', 'd4b3cec46777f6f58057126961fbf1a287b60a2ef398af41d58c717e9dc1b8ee')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:356', @guest_id, 'Guest', 'Imported Record 0355', 'Japan', 'JP', 'Junior Suite', 9, 'high', 20763, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0356', 'JP', 'Japan', '693354b75477d7dfd9cd5752e62c4a7032694c4c85a2b28de3b71a5db6683732')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:357', @guest_id, 'Guest', 'Imported Record 0356', 'Japan', 'JP', 'Junior Suite', 7, 'low', 15365, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0357', 'GB', 'United Kingdom', '2ff4ca76145b462c2b5fa5bfd502f77ba904ecd5a6ae366e6fe07e0c9931fa2f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:358', @guest_id, 'Guest', 'Imported Record 0357', 'United Kingdom', 'GB', 'LOFT Suite', 6, 'low', 19416, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0358', 'DE', 'Germany', '28de5b6e4cf532368625b79e86e03d2bb4757324f6789537497efc6e9ccc3533')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:359', @guest_id, 'Guest', 'Imported Record 0358', 'Germany', 'DE', 'Suite', 7, 'high', 23240, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0359', 'VN', 'Vietnam', 'b97777568028a9de0620a31fec112ae5047cc76c76e08450bec8a8373027fd9f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:360', @guest_id, 'Guest', 'Imported Record 0359', 'Vietnam', 'VN', 'Grand Lit', 4, 'mid', 6028, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0360', 'EG', 'Egypt', 'f03626b2ad7aab7d2f7ec47fcc741f833ac0fc70c64a63bca59ea143899ce30b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:361', @guest_id, 'Guest', 'Imported Record 0360', 'Egypt', 'EG', 'Spa Executive', 8, 'low', 18840, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0361', 'PK', 'Pakistan', '26911df72ffac95e135b952649f8698041b2cff24ce8c114e10671a2f79fbfef')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:362', @guest_id, 'Guest', 'Imported Record 0361', 'Pakistan', 'PK', 'Spa Executive', 10, 'mid', 23890, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0362', 'US', 'United States', '53a9809633cdced553795e9c5180ba99b6e15cf9825b8774315a1ee1d4f9ffde')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:363', @guest_id, 'Guest', 'Imported Record 0362', 'United States', 'US', 'Junior Suite', 5, 'high', 12420, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0363', 'SE', 'Sweden', '4a62917f64d0035a4834bac0e50b29a05546381d7ec97103b9d6aaba4ed9dc5e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:364', @guest_id, 'Guest', 'Imported Record 0363', 'Sweden', 'SE', 'LOFT Suite', 6, 'high', 22368, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0364', 'RU', 'Russia', '2c55a8698ee2a2f5f51f2e254fbcdf23381acdf815543930f91486c19ed51276')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:365', @guest_id, 'Guest', 'Imported Record 0364', 'Russia', 'RU', 'Standard Single', 5, 'low', 5125, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0365', 'NG', 'Nigeria', 'efdf0c292e20d996eb6ba6429c6cd0a4bbf3758dd571161a845775f649322ea6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:366', @guest_id, 'Guest', 'Imported Record 0365', 'Nigeria', 'NG', 'Standard Single', 6, 'mid', 7500, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0366', 'SE', 'Sweden', '005c3f20f5b98b05376d53517908309a9d890d06e840af25f36c66cf9d085755')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:367', @guest_id, 'Guest', 'Imported Record 0366', 'Sweden', 'SE', 'Junior Suite', 10, 'high', 22870, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0367', 'CA', 'Canada', '6e5de6549d9de4ecddb367fdba97ba5f5b2f5eb9b9c2b1bb9d0e0ce82645cb1d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:368', @guest_id, 'Guest', 'Imported Record 0367', 'Canada', 'CA', 'LOFT Suite', 2, 'mid', 6886, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0368', 'KR', 'South Korea', '832209abf697f8c30d5a7b94f543209a98c9360684b392721d9a79d7037a8b3c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:369', @guest_id, 'Guest', 'Imported Record 0368', 'South Korea', 'KR', 'LOFT Suite', 1, 'high', 3522, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0369', 'KR', 'South Korea', 'dfa2632b1ae5210512dfd4e4bcc72e6617ea6b943edab557dc23e62c78663b5c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:370', @guest_id, 'Guest', 'Imported Record 0369', 'South Korea', 'KR', 'Suite', 1, 'high', 3162, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0370', 'JP', 'Japan', '963f00c9661a3a6f192017a87796f9c61fd18a80feb052795d59b460dca1de37')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:371', @guest_id, 'Guest', 'Imported Record 0370', 'Japan', 'JP', 'Standard Double', 10, 'high', 17080, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0371', 'KR', 'South Korea', '0ed84b03c4590ba8986aaa70d56fa1c62c3fb38ba650339bfba99426743f2eda')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:372', @guest_id, 'Guest', 'Imported Record 0371', 'South Korea', 'KR', 'LOFT Suite', 10, 'low', 31010, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0372', 'AU', 'Australia', '38de88de54c45c6fdac7daeb7e89259c66dd25d79601cc7ea32931c547fb8314')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:373', @guest_id, 'Guest', 'Imported Record 0372', 'Australia', 'AU', 'Grand Lit', 7, 'low', 9471, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0373', 'MX', 'Mexico', 'ad4f95266872a1368129ca0d524aadaac179f0516bde0e5aa27d8b168e265ffd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:374', @guest_id, 'Guest', 'Imported Record 0373', 'Mexico', 'MX', 'Suite', 7, 'low', 18823, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0374', 'SE', 'Sweden', '7113043d4ac56bb315640c86b63b071ca0a3b491fe7507f221482eedd3393b93')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:375', @guest_id, 'Guest', 'Imported Record 0374', 'Sweden', 'SE', 'Superior Double', 8, 'high', 15240, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0375', 'VN', 'Vietnam', 'c24fb2228f1b7ec9a1ae615b884b7051b9eefe4540e62ee9f7ba42ce05cc4e05')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:376', @guest_id, 'Guest', 'Imported Record 0375', 'Vietnam', 'VN', 'Spa Executive', 6, 'high', 15522, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0376', 'VN', 'Vietnam', 'b7f5082c9effdf33d6b52ab273e2b2aeba5d60df8be9191377355ff84ca9e73a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:377', @guest_id, 'Guest', 'Imported Record 0376', 'Vietnam', 'VN', 'Suite', 2, 'high', 6786, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0377', 'SE', 'Sweden', 'ec921d80b55620e18d314203b403a2add8480b6d7c9041e598ae2aeba37c1960')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:378', @guest_id, 'Guest', 'Imported Record 0377', 'Sweden', 'SE', 'Standard Single', 1, 'high', 1312, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0378', 'GB', 'United Kingdom', '658fc484e41cbf263d21822d7c30b02460ed3612148cf50be6ad8621671ffe05')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:379', @guest_id, 'Guest', 'Imported Record 0378', 'United Kingdom', 'GB', 'Spa Executive', 6, 'mid', 14778, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0379', 'RU', 'Russia', 'ca2f1f7c0607d3d2f26cfb3a22c34feebe02ccb7beb47ca46a665bd79a0ddca2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:380', @guest_id, 'Guest', 'Imported Record 0379', 'Russia', 'RU', 'Standard Single', 10, 'low', 9580, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0380', 'VN', 'Vietnam', 'a3acff136d08bd10c29ebca3bb08b0fd9ecd774b1ed12077491145420917e11a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:381', @guest_id, 'Guest', 'Imported Record 0380', 'Vietnam', 'VN', 'Spa Executive', 4, 'mid', 9760, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0381', 'GB', 'United Kingdom', '8f52893cddb343f041aa928ef6561efa0537b6c7deeedb799752c08f545579f9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:382', @guest_id, 'Guest', 'Imported Record 0381', 'United Kingdom', 'GB', 'Spa Executive', 9, 'low', 19584, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0382', 'MX', 'Mexico', '03a5ce8d7215d4c7ffb908e8735bb8b89d0cc36759e94ee18df05bad80d40e5d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:383', @guest_id, 'Guest', 'Imported Record 0382', 'Mexico', 'MX', 'Suite', 3, 'low', 7560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0383', 'GB', 'United Kingdom', '09a81da3645c294ce28c17047547b4eb45ffe353e5e854cd84ad4154741810ab')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:384', @guest_id, 'Guest', 'Imported Record 0383', 'United Kingdom', 'GB', 'Junior Suite', 5, 'high', 11745, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0384', 'NG', 'Nigeria', 'fe3a06d712002ce8ca8c5136c0c000154a19b66456293ff852bdd9084e5e28bf')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:385', @guest_id, 'Guest', 'Imported Record 0384', 'Nigeria', 'NG', 'Junior Suite', 3, 'high', 7002, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0385', 'FR', 'France', '2c3df111c6b679856af8805d91460c9bf5a0e0092dfb67d7fcd40dd08d416f9e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:386', @guest_id, 'Guest', 'Imported Record 0385', 'France', 'FR', 'Superior Double', 6, 'high', 10962, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0386', 'KR', 'South Korea', '88921a96edf2b64bb3c24b6b0d935da59fde8d137ad83c0919ed41ef282c2874')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:387', @guest_id, 'Guest', 'Imported Record 0386', 'South Korea', 'KR', 'Standard Double', 1, 'high', 1807, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0387', 'EG', 'Egypt', 'c914458a79d06285f63b4c99f76456256e643e2a9a33ad6650af5c58e7a1ccd0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:388', @guest_id, 'Guest', 'Imported Record 0387', 'Egypt', 'EG', 'Junior Suite', 6, 'mid', 13506, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0388', 'CN', 'China', '5173063ea8810c5ffb86bcf43b082f9bc602a7dae871cd90178a88bd6e970700')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:389', @guest_id, 'Guest', 'Imported Record 0388', 'China', 'CN', 'Standard Double', 3, 'mid', 4032, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0389', 'CA', 'Canada', 'bcdf2b93713614ad38c5b31231a7a12a0a27caa3863b2191e75a468924597ebd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:390', @guest_id, 'Guest', 'Imported Record 0389', 'Canada', 'CA', 'Junior Suite', 7, 'mid', 14560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0390', 'JP', 'Japan', '0203171b1ff5d15e766d04f10ada04e64360b4fb9cd81e2fc3ac1da1fa0a8109')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:391', @guest_id, 'Guest', 'Imported Record 0390', 'Japan', 'JP', 'Standard Double', 10, 'mid', 16260, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0391', 'RU', 'Russia', '58fd8f3a69a5b71f027a2408cfe0443d1c875c6fc0136fea1f9e8d3858336806')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:392', @guest_id, 'Guest', 'Imported Record 0391', 'Russia', 'RU', 'Suite', 2, 'mid', 5906, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0392', 'VN', 'Vietnam', '8379d224086ab750b0d738f168ae484097414e512d97045b4add7543a5b25c0f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:393', @guest_id, 'Guest', 'Imported Record 0392', 'Vietnam', 'VN', 'LOFT Suite', 4, 'mid', 14076, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0393', 'KR', 'South Korea', 'b04d145a38c1b222d344f5baa1de13ce4ac0b0ac1d3f990be60a086d81dc2bd9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:394', @guest_id, 'Guest', 'Imported Record 0393', 'South Korea', 'KR', 'Superior Double', 9, 'mid', 15516, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0394', 'CN', 'China', '11e04c970d92991e6e5293608f2a19d3408917bde98937f25f1fea92dcf79fa6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:395', @guest_id, 'Guest', 'Imported Record 0394', 'China', 'CN', 'LOFT Suite', 2, 'mid', 7470, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0395', 'NG', 'Nigeria', '9ab2927c5688a50622f944c5390ff53e215adfd5576f8dff950ae65e4b05d90f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:396', @guest_id, 'Guest', 'Imported Record 0395', 'Nigeria', 'NG', 'Spa Executive', 7, 'low', 16373, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0396', 'VN', 'Vietnam', 'b052583c1860f8d20ca067b9b284ad62013d3b15375be80070e97019fc5cfe20')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:397', @guest_id, 'Guest', 'Imported Record 0396', 'Vietnam', 'VN', 'Suite', 1, 'low', 2850, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0397', 'AU', 'Australia', '74c4343ecc05e6cd7873563bae58ed03ecdfd88b4832cf5e74743b0da37559cf')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:398', @guest_id, 'Guest', 'Imported Record 0397', 'Australia', 'AU', 'Superior Double', 9, 'low', 13761, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0398', 'SE', 'Sweden', 'e809b26f7790f8e11f511e5266bdb5ddf173bb57ff16343fdf1db75b9b7b5ecd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:399', @guest_id, 'Guest', 'Imported Record 0398', 'Sweden', 'SE', 'Grand Lit', 9, 'mid', 13392, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0399', 'CN', 'China', 'd9e754dd0707dbbd3a927ac4746f43e1deba223a7ae3735f2b5e692d74f57464')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:400', @guest_id, 'Guest', 'Imported Record 0399', 'China', 'CN', 'Suite', 10, 'mid', 30350, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0400', 'RU', 'Russia', '0b54c3bf6f6e6dcdd720fbd1f6b23f5cd554044f553e737eeb17ab4333b64e8c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:401', @guest_id, 'Guest', 'Imported Record 0400', 'Russia', 'RU', 'Junior Suite', 5, 'high', 11205, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0401', 'GB', 'United Kingdom', '8f89c565689e4a79825fab522df84f1952c907df5cc7ba1d7fb16de8b6272c55')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:402', @guest_id, 'Guest', 'Imported Record 0401', 'United Kingdom', 'GB', 'Superior Double', 1, 'low', 1528, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0402', 'AU', 'Australia', 'ad89f7a0610bbffff863be5e904d00add06c349f49b3b41310356ada504336d0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:403', @guest_id, 'Guest', 'Imported Record 0402', 'Australia', 'AU', 'Junior Suite', 7, 'low', 12824, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0403', 'AU', 'Australia', '1e396b117515c653d49f04e29c9321b5f79e6b3ca0f5656093464fe944122474')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:404', @guest_id, 'Guest', 'Imported Record 0403', 'Australia', 'AU', 'Suite', 9, 'mid', 29592, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0404', 'US', 'United States', '88991dee358fb2a4d8c186578ffbce5d0b2d97118900e1c1948b06654ea3a24c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:405', @guest_id, 'Guest', 'Imported Record 0404', 'United States', 'US', 'Superior Double', 10, 'mid', 18100, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0405', 'PK', 'Pakistan', 'd497110bb57b71b448a034f1abc5f738cb59e0e456177243393a67ebaeac63b5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:406', @guest_id, 'Guest', 'Imported Record 0405', 'Pakistan', 'PK', 'Spa Executive', 1, 'low', 2149, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0406', 'US', 'United States', 'f92b785cae3255354d691b39876ccd6099a7aa597df2024e31cf7ac0167d5a72')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:407', @guest_id, 'Guest', 'Imported Record 0406', 'United States', 'US', 'Standard Double', 7, 'low', 10906, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0407', 'MX', 'Mexico', '27826181a82aea6deb3a3e119c4ba9c11d0e84bd3f2ff570e2b427f5b0279126')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:408', @guest_id, 'Guest', 'Imported Record 0407', 'Mexico', 'MX', 'Grand Lit', 4, 'high', 6892, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0408', 'IN', 'India', '622dc9eb0b21d6d309fb2714a511b2bf34f504a4cc5b05c87219b2f7aab41b09')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:409', @guest_id, 'Guest', 'Imported Record 0408', 'India', 'IN', 'Suite', 1, 'low', 2627, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0409', 'NG', 'Nigeria', 'b6c90aa6732f99e0b75306962cbdfe0a1a6fdc428de79167d577dc16dcfb9b63')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:410', @guest_id, 'Guest', 'Imported Record 0409', 'Nigeria', 'NG', 'Junior Suite', 3, 'mid', 7101, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0410', 'MX', 'Mexico', 'ebd06240c0103edc5384b6c758a5faa98ff789597e5ecabfb9d72719eec2418c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:411', @guest_id, 'Guest', 'Imported Record 0410', 'Mexico', 'MX', 'Superior Double', 8, 'mid', 15888, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0411', 'SE', 'Sweden', '99b9d35ccf50df1c25e5c0fd11025153e33c4bb0ee143d204a8a3315e907de72')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:412', @guest_id, 'Guest', 'Imported Record 0411', 'Sweden', 'SE', 'Suite', 7, 'mid', 22981, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0412', 'BR', 'Brazil', '25fa590bb43a70a9b662451c65f392bfd169fd052fc0a2936dc0289ead77a913')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:413', @guest_id, 'Guest', 'Imported Record 0412', 'Brazil', 'BR', 'Spa Executive', 4, 'high', 10412, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0413', 'AU', 'Australia', '7445b2a4b6fda3013c88aea32127359b82e06b211fe13efd8790882277f1d69a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:414', @guest_id, 'Guest', 'Imported Record 0413', 'Australia', 'AU', 'Suite', 4, 'mid', 11744, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0414', 'IT', 'Italy', '747f5464fe5b1360607d08b49e28cd7f58db5e341afe0818196d6a41eeabc46b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:415', @guest_id, 'Guest', 'Imported Record 0414', 'Italy', 'IT', 'Spa Executive', 8, 'low', 17920, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0415', 'DE', 'Germany', '9c4c54aa64a2862a5c7d367f6f721973db330565e3338f99435bd1d82cc22c44')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:416', @guest_id, 'Guest', 'Imported Record 0415', 'Germany', 'DE', 'LOFT Suite', 8, 'low', 24560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0416', 'VN', 'Vietnam', 'bbf809900c4936204b214d4af1bb6dc0ddd10f75620dbfce1b9807881612ac1a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:417', @guest_id, 'Guest', 'Imported Record 0416', 'Vietnam', 'VN', 'Superior Double', 4, 'mid', 6616, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0417', 'JP', 'Japan', 'a61253c988d3fcbd3b72c657905b2da456160419a9a4d9650187098a5741cdbc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:418', @guest_id, 'Guest', 'Imported Record 0417', 'Japan', 'JP', 'Superior Double', 2, 'high', 4206, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0418', 'CN', 'China', '5714cd3ce6e5e59dd42f03bee0f2c778fa593223015126eb45e556e2ac31816a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:419', @guest_id, 'Guest', 'Imported Record 0418', 'China', 'CN', 'Suite', 6, 'mid', 16290, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0419', 'NG', 'Nigeria', '87657cdcc36bba4b348991e5d24ff39d19c84884e2861523dfa817edc1d7479a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:420', @guest_id, 'Guest', 'Imported Record 0419', 'Nigeria', 'NG', 'Standard Single', 9, 'high', 12213, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0420', 'VN', 'Vietnam', 'd766b8e05772b17fc2e3f836b6d4c03f3df996b8c5acdfc3fa2dbe858cc2abc2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:421', @guest_id, 'Guest', 'Imported Record 0420', 'Vietnam', 'VN', 'Standard Double', 2, 'mid', 3142, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0421', 'MX', 'Mexico', '66ad7005cbc97bb0e33e0c0acee4350b13cdb5bbfd2a7b52381f244ad168b6bc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:422', @guest_id, 'Guest', 'Imported Record 0421', 'Mexico', 'MX', 'Standard Double', 1, 'low', 1287, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0422', 'PK', 'Pakistan', 'dba7bdf42286dc2ea18ffca7a1badf069b2ca716dd6570ff7a5dd0d6e2fdb661')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:423', @guest_id, 'Guest', 'Imported Record 0422', 'Pakistan', 'PK', 'Standard Single', 9, 'high', 10953, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0423', 'DE', 'Germany', '35fc07058ba6a481c194c75d620c8b207ffc4498d5283219e20f0ca2e93ba2fd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:424', @guest_id, 'Guest', 'Imported Record 0423', 'Germany', 'DE', 'Standard Double', 7, 'low', 8638, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0424', 'AU', 'Australia', '781bb1bbcf28aed546f3d2767525e4942b4b1079811379571d45d88971bb449c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:425', @guest_id, 'Guest', 'Imported Record 0424', 'Australia', 'AU', 'Grand Lit', 10, 'low', 12420, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0425', 'EG', 'Egypt', '5d440d600f85d19b909bbd0c5d143dac5d5f9583b34e95246f1506a455486047')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:426', @guest_id, 'Guest', 'Imported Record 0425', 'Egypt', 'EG', 'Grand Lit', 3, 'low', 3495, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0426', 'FR', 'France', '196919e8dbea953e6f18226a96ed4a2e86b5c1ee92df486eb07ee87de0c6a4e7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:427', @guest_id, 'Guest', 'Imported Record 0426', 'France', 'FR', 'Suite', 1, 'low', 2815, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0427', 'JP', 'Japan', 'dbf2a80a0e8ef56dcdad8169a7bb2e210b8eb98973a72c7ec086c5ecc8b14d12')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:428', @guest_id, 'Guest', 'Imported Record 0427', 'Japan', 'JP', 'Grand Lit', 9, 'mid', 11826, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0428', 'IT', 'Italy', 'cb03199eb322478052489822e5c4eb9d090ba13de7eceb057216d7cea1b4b4a8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:429', @guest_id, 'Guest', 'Imported Record 0428', 'Italy', 'IT', 'Grand Lit', 8, 'high', 13128, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0429', 'DE', 'Germany', '9a269f6d0f87f50b4480daaae77526bb282040a2ebbdb21454d0ebfb093ef935')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:430', @guest_id, 'Guest', 'Imported Record 0429', 'Germany', 'DE', 'Grand Lit', 3, 'mid', 3972, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0430', 'IN', 'India', 'ba849186ff7aae572781ba31a3fb583ae70daf912055f04e1d5635ca63517b9d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:431', @guest_id, 'Guest', 'Imported Record 0430', 'India', 'IN', 'Spa Executive', 5, 'mid', 11025, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0431', 'ES', 'Spain', 'e145f7bfb3beb5c871998bb78f942caa59ad84b9b4bb184ec88446d525ce6c37')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:432', @guest_id, 'Guest', 'Imported Record 0431', 'Spain', 'ES', 'Spa Executive', 1, 'low', 2376, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0432', 'IT', 'Italy', 'd325ed286c15026b3ddf745e1e52bf67f7c22ffe11f49c9f839a6a0e3426cb71')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:433', @guest_id, 'Guest', 'Imported Record 0432', 'Italy', 'IT', 'Junior Suite', 5, 'high', 11515, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0433', 'VN', 'Vietnam', 'af6d7d20b2bcf0e54a6d7676126fdfc3ee5f74531f010d50ab6cce5b05043587')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:434', @guest_id, 'Guest', 'Imported Record 0433', 'Vietnam', 'VN', 'Standard Double', 4, 'high', 6444, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0434', 'CN', 'China', '135aa16e5ee446163f57ca41ea53147c428ec3cf88cb960b33e9a3904b3c8883')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:435', @guest_id, 'Guest', 'Imported Record 0434', 'China', 'CN', 'Suite', 1, 'high', 3265, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0435', 'SE', 'Sweden', 'fb47161aedd10b3c4c8b276cf0f58b9783c9e7749a859d5ddf34b298fcebd3e0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:436', @guest_id, 'Guest', 'Imported Record 0435', 'Sweden', 'SE', 'Suite', 6, 'mid', 17868, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0436', 'ES', 'Spain', '2f0a1f5ac22713da0cd053e6e79283bb84fca82fb86a42f57977e60b35e78880')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:437', @guest_id, 'Guest', 'Imported Record 0436', 'Spain', 'ES', 'Grand Lit', 8, 'mid', 10656, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0437', 'BR', 'Brazil', 'cbf89ab3847b33892464405a65ed17ec3ada3b8e779a8b7183b765e73da42f90')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:438', @guest_id, 'Guest', 'Imported Record 0437', 'Brazil', 'BR', 'Superior Double', 1, 'high', 1884, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0438', 'CN', 'China', '5f42b431616dc246f52ca05b56937b06c97022eac908860a7eba91ed841d8d79')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:439', @guest_id, 'Guest', 'Imported Record 0438', 'China', 'CN', 'Standard Single', 2, 'mid', 2222, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0439', 'SE', 'Sweden', '0069b18e78a6804e5ce52f471b4d872081ecb0bce1e0e73cfb88fdc4e2d966ad')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:440', @guest_id, 'Guest', 'Imported Record 0439', 'Sweden', 'SE', 'Suite', 5, 'low', 13155, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0440', 'IN', 'India', '09b646afad90c69e682319d55430a51ebed252cde315d302dea1224a851312f4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:441', @guest_id, 'Guest', 'Imported Record 0440', 'India', 'IN', 'Suite', 2, 'low', 5868, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0441', 'PK', 'Pakistan', '1fccdd4b0eae04d0c0f313439280ee48c30b72eda09f78fe429ff01a83130295')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:442', @guest_id, 'Guest', 'Imported Record 0441', 'Pakistan', 'PK', 'Suite', 4, 'high', 12836, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0442', 'CN', 'China', '2bc55594e6ddbba58164c0bdafc318614be8348ff1a6b6401eed1ee225f716f3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:443', @guest_id, 'Guest', 'Imported Record 0442', 'China', 'CN', 'Spa Executive', 6, 'high', 16320, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0443', 'KR', 'South Korea', '5895b66f9b705a95ffe40b901d1f3dc0a610ffb473ff9e3ee4fa2fd0c3c32222')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:444', @guest_id, 'Guest', 'Imported Record 0443', 'South Korea', 'KR', 'Junior Suite', 9, 'mid', 20448, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0444', 'US', 'United States', 'efdb06b2689a0309f863c44d0ad8da4c5fe955ff8aac403e4261f193b548018c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:445', @guest_id, 'Guest', 'Imported Record 0444', 'United States', 'US', 'Standard Single', 7, 'mid', 7560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0445', 'RU', 'Russia', '90252e4512d85d97c5a52aca364ec33ebeb8528e78471b41c8aeec81550b8cf1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:446', @guest_id, 'Guest', 'Imported Record 0445', 'Russia', 'RU', 'Superior Double', 1, 'mid', 1884, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0446', 'JP', 'Japan', 'ff608477cf5bac42a8f64985c04474554ecf64aa0da87748ca1c4e9bf2c6f13b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:447', @guest_id, 'Guest', 'Imported Record 0446', 'Japan', 'JP', 'Superior Double', 2, 'mid', 3864, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0447', 'ES', 'Spain', '09e0ed73b09925d9615a7bea7f6bea9c94f5d00025a6f4b63459466a2e1f2662')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:448', @guest_id, 'Guest', 'Imported Record 0447', 'Spain', 'ES', 'Suite', 3, 'low', 7926, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0448', 'FR', 'France', '34245d7dc03ef062e30f366d2df0d3e269c8f6d7c94e00f1424c6940a324aabe')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:449', @guest_id, 'Guest', 'Imported Record 0448', 'France', 'FR', 'Superior Double', 6, 'low', 10056, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0449', 'RU', 'Russia', 'a82cdba02f858d24567f293a96ac0932e5b73aab86a2af98d632640a56feafff')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:450', @guest_id, 'Guest', 'Imported Record 0449', 'Russia', 'RU', 'Standard Single', 3, 'low', 2733, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0450', 'US', 'United States', '0776ae61d9730763bd875c72ec6a190a9d2f84f0307788e5931c494b9483a0e9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:451', @guest_id, 'Guest', 'Imported Record 0450', 'United States', 'US', 'Spa Executive', 2, 'high', 5206, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0451', 'EG', 'Egypt', '6f2da422057b731645b72f9773eb2b989d9acbcef82a84f59e6a5ddd022c2601')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:452', @guest_id, 'Guest', 'Imported Record 0451', 'Egypt', 'EG', 'Standard Single', 2, 'high', 2654, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0452', 'JP', 'Japan', '5408e174580cfcd7cabe4fdcfa9803c8d45b1dd1bf8543aca7b59371b5a95b8f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:453', @guest_id, 'Guest', 'Imported Record 0452', 'Japan', 'JP', 'Suite', 3, 'low', 7623, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0453', 'JP', 'Japan', 'c1c0130c54a18325fe53f0cacc6501747fbf89e265a94c24f47c74e93bda8b72')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:454', @guest_id, 'Guest', 'Imported Record 0453', 'Japan', 'JP', 'Superior Double', 6, 'high', 12402, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0454', 'MX', 'Mexico', '26ff0ec9c6a29dcddffdba175fbc2816b65bfb720f0ed70b788bb19f0ee23f8f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:455', @guest_id, 'Guest', 'Imported Record 0454', 'Mexico', 'MX', 'Junior Suite', 1, 'high', 2299, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0455', 'GB', 'United Kingdom', '38140af41b129fab0c4766b39c762a4dcc3529acc5664ec582d17420fb8f5108')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:456', @guest_id, 'Guest', 'Imported Record 0455', 'United Kingdom', 'GB', 'Superior Double', 9, 'low', 15444, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0456', 'DE', 'Germany', 'dd6822cf848e8d8db52493055076ba5ade4b8f89349d54ce1424dfef0b1e7f4a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:457', @guest_id, 'Guest', 'Imported Record 0456', 'Germany', 'DE', 'Junior Suite', 5, 'low', 10205, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0457', 'AU', 'Australia', '21b61346e42f19ae28546acfa0e44bb60a665c1dc48624c04dc71c4c2c8aefb6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:458', @guest_id, 'Guest', 'Imported Record 0457', 'Australia', 'AU', 'Spa Executive', 3, 'low', 6987, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0458', 'CA', 'Canada', '94fc942ffca6a67488e51da7a3c1343736c9f5511d08dd35356ffcc3da395179')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:459', @guest_id, 'Guest', 'Imported Record 0458', 'Canada', 'CA', 'Superior Double', 7, 'mid', 12614, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0459', 'AU', 'Australia', '9a1a1c3a8809a5122148b2bc12d3683b3472d1d00019ad66d86d081c6a0cf6ed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:460', @guest_id, 'Guest', 'Imported Record 0459', 'Australia', 'AU', 'Grand Lit', 2, 'low', 2454, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0460', 'BR', 'Brazil', '3bbcd1368f84993df7424f00b018d40007a15ed63f143aaba5dfcd41fb9925b6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:461', @guest_id, 'Guest', 'Imported Record 0460', 'Brazil', 'BR', 'LOFT Suite', 8, 'mid', 26312, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0461', 'PK', 'Pakistan', 'd66399ddae358233c11f04f835642894b8c5be3254943a71419211fe415f6809')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:462', @guest_id, 'Guest', 'Imported Record 0461', 'Pakistan', 'PK', 'Standard Double', 6, 'mid', 9066, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0462', 'SE', 'Sweden', '82e9bb416a00ba4d855c7539de434910f5d72e32019bb986ae6661c97da299c0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:463', @guest_id, 'Guest', 'Imported Record 0462', 'Sweden', 'SE', 'Standard Single', 1, 'low', 1162, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0463', 'SE', 'Sweden', '6ba4c16cc14a1f01769d1b4e16ff86388571ee792cc7e23058b0843fca1c0696')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:464', @guest_id, 'Guest', 'Imported Record 0463', 'Sweden', 'SE', 'Grand Lit', 1, 'mid', 1448, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0464', 'FR', 'France', '3249d7e63bf147f9696e4d75f3ea97422fccfc8753cd6c177ac41b83d588033e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:465', @guest_id, 'Guest', 'Imported Record 0464', 'France', 'FR', 'Grand Lit', 8, 'mid', 12624, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0465', 'EG', 'Egypt', '95ca820143a5ee82bf61259805994b19d2eee3eba1369d278bfc057d7a57b42c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:466', @guest_id, 'Guest', 'Imported Record 0465', 'Egypt', 'EG', 'Standard Double', 2, 'high', 3268, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0466', 'CN', 'China', '55c6eb7313c23d63a03ff3b26a4ac45ed599e77885562ed9a01d41abbb651660')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:467', @guest_id, 'Guest', 'Imported Record 0466', 'China', 'CN', 'Standard Single', 9, 'high', 12780, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0467', 'KR', 'South Korea', '806215e58b4c56dae53dc77ac07ee9070f3d17d704d53ed965a717a12ddb61dd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:468', @guest_id, 'Guest', 'Imported Record 0467', 'South Korea', 'KR', 'Superior Double', 2, 'low', 3218, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0468', 'CA', 'Canada', '130ca76ad383e0f4677767e1fb2908e98ca3c71b3b3510d4d0a22da7550762b8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:469', @guest_id, 'Guest', 'Imported Record 0468', 'Canada', 'CA', 'Junior Suite', 10, 'low', 18530, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0469', 'SE', 'Sweden', '37e9f6129edf0d0e1f5d7ebefababcd9f1af740a4f5f67416cba38c811f327ac')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:470', @guest_id, 'Guest', 'Imported Record 0469', 'Sweden', 'SE', 'Spa Executive', 1, 'low', 2168, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0470', 'AU', 'Australia', 'e480579880ab660f3af5158df0b0d97c0f8d37b7c19819bbafe7a1a16db1cebf')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:471', @guest_id, 'Guest', 'Imported Record 0470', 'Australia', 'AU', 'Grand Lit', 4, 'high', 5768, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0471', 'PK', 'Pakistan', 'c85eeaabb8b117bce7b619c55b33c523395a00e85979c8618a17dd4d557ecb90')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:472', @guest_id, 'Guest', 'Imported Record 0471', 'Pakistan', 'PK', 'LOFT Suite', 8, 'high', 30464, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0472', 'US', 'United States', 'c1f99aa7e1f445966b8c0c075ef87c4625196baea06dc79ad42d5f841d615643')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:473', @guest_id, 'Guest', 'Imported Record 0472', 'United States', 'US', 'Grand Lit', 9, 'high', 14175, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0473', 'IN', 'India', '968222fffcfa35f3421b4555addd1b300ef93b13367cae3fb4aa0e433bdd77ab')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:474', @guest_id, 'Guest', 'Imported Record 0473', 'India', 'IN', 'LOFT Suite', 7, 'high', 25641, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0474', 'RU', 'Russia', 'fa71c8f764b20146082eacaabd0157447c215610eece8ca8f1fabafcc6af8945')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:475', @guest_id, 'Guest', 'Imported Record 0474', 'Russia', 'RU', 'Suite', 9, 'mid', 25992, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0475', 'KR', 'South Korea', 'a2edfac721c9f51b7ecbbf97c9d7abf7fa930e5c5c3018aae2caefff5be1e1d1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:476', @guest_id, 'Guest', 'Imported Record 0475', 'South Korea', 'KR', 'Standard Double', 8, 'low', 12120, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0476', 'IN', 'India', '32cd8adde505de134af74732ae430aa712f34342e0968c6d96a92a0eeca9aa01')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:477', @guest_id, 'Guest', 'Imported Record 0476', 'India', 'IN', 'Standard Single', 6, 'mid', 7464, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0477', 'MX', 'Mexico', 'fc6751e62257df25c161b2a92920e37f9785317d68db080a44c164f2487b77d7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:478', @guest_id, 'Guest', 'Imported Record 0477', 'Mexico', 'MX', 'LOFT Suite', 8, 'high', 30096, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0478', 'MX', 'Mexico', 'f9b080dc7c648c2dec13fa3653785d9bbed8b30dee59a2640dd30c329d474ad5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:479', @guest_id, 'Guest', 'Imported Record 0478', 'Mexico', 'MX', 'Spa Executive', 5, 'high', 13820, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0479', 'DE', 'Germany', '99adc9f933d8890209775bf2b1443b7108485b66fd07bef38e9dbde8b6181e44')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:480', @guest_id, 'Guest', 'Imported Record 0479', 'Germany', 'DE', 'LOFT Suite', 4, 'mid', 13296, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0480', 'IN', 'India', '9e731f61822fdcd129e3078bbb33d809737c9fe92b450e71031f378936e79ce6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:481', @guest_id, 'Guest', 'Imported Record 0480', 'India', 'IN', 'Suite', 1, 'low', 2717, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0481', 'BR', 'Brazil', '4c0b3fbca2410b3904bd8d38a63dae740c80ebe70832a738769ba538d2d5afe4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:482', @guest_id, 'Guest', 'Imported Record 0481', 'Brazil', 'BR', 'LOFT Suite', 2, 'high', 7670, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0482', 'ES', 'Spain', '53f7bb4f4b987e90c9640bbf14906d910708b35b7cf530f51776a81b0c4131cc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:483', @guest_id, 'Guest', 'Imported Record 0482', 'Spain', 'ES', 'Standard Single', 3, 'mid', 3753, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0483', 'IT', 'Italy', '561da0b34aa78fa988570a4b86974e3178906e7c84eb3c1c6c7cab414984886c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:484', @guest_id, 'Guest', 'Imported Record 0483', 'Italy', 'IT', 'LOFT Suite', 2, 'mid', 7190, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0484', 'SE', 'Sweden', '2d2f260c4fea65ad037d6c9a88a7cf6d6aadf6ab838654a567465d4d1ff8dd11')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:485', @guest_id, 'Guest', 'Imported Record 0484', 'Sweden', 'SE', 'Standard Single', 1, 'high', 1387, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0485', 'FR', 'France', '1d7f74a0ab5dee10c11eaf5991971273195e9c0e2c4c2b74c2142ccbad078eee')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:486', @guest_id, 'Guest', 'Imported Record 0485', 'France', 'FR', 'Spa Executive', 2, 'mid', 4792, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0486', 'FR', 'France', '29784680b20e1bb490cc3d37987e1446438b38950a657309ec6896fe861181e7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:487', @guest_id, 'Guest', 'Imported Record 0486', 'France', 'FR', 'Grand Lit', 5, 'low', 5715, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0487', 'NG', 'Nigeria', '195efd21283a49204a0f7b8992b6078605868bda92313c8704c685a93de61001')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:488', @guest_id, 'Guest', 'Imported Record 0487', 'Nigeria', 'NG', 'Standard Double', 3, 'low', 3951, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0488', 'FR', 'France', '363f459b08b3c9e886fe8aa55876b9a52fc2085409bddaf067016e35ea7ab15b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:489', @guest_id, 'Guest', 'Imported Record 0488', 'France', 'FR', 'Grand Lit', 3, 'low', 3933, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0489', 'MX', 'Mexico', 'eeb0669d4d03cb04dac7efd5fda27713b62567976b848d00160685c334725beb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:490', @guest_id, 'Guest', 'Imported Record 0489', 'Mexico', 'MX', 'LOFT Suite', 4, 'high', 15188, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0490', 'PK', 'Pakistan', '720edb092eb15b73a8f8ef0a1de88977508f6acceccd93028e7b98fe87a6a0fb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:491', @guest_id, 'Guest', 'Imported Record 0490', 'Pakistan', 'PK', 'Spa Executive', 9, 'low', 18675, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0491', 'KR', 'South Korea', 'cff7c3d0c486e1774e80a49530b19ea752c9b299fdbdd612fddf07971ef4b4b3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:492', @guest_id, 'Guest', 'Imported Record 0491', 'South Korea', 'KR', 'Grand Lit', 10, 'low', 12310, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0492', 'CA', 'Canada', '1dfe73658ebbd1c975861851ae4909b724c13ac9d386e423c98a999f507e4538')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:493', @guest_id, 'Guest', 'Imported Record 0492', 'Canada', 'CA', 'Standard Single', 3, 'low', 2808, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0493', 'AU', 'Australia', 'f48675c595338c31930f854b0d5452787f08ccf518959dca745c0d8b509ec3dc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:494', @guest_id, 'Guest', 'Imported Record 0493', 'Australia', 'AU', 'Standard Single', 4, 'low', 4140, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0494', 'FR', 'France', '67cf36d9893fd27743b2b8709e249c0618171c7f8e4e3098bf226728bf67c357')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:495', @guest_id, 'Guest', 'Imported Record 0494', 'France', 'FR', 'LOFT Suite', 4, 'low', 13784, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0495', 'NG', 'Nigeria', '7302d554b91f465bc52f3686ef2602165348c8031b07f83ab0da0d44511e55c5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:496', @guest_id, 'Guest', 'Imported Record 0495', 'Nigeria', 'NG', 'Spa Executive', 10, 'high', 26530, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0496', 'IN', 'India', 'f5dc9e45611f3e853ead6fe0d0986224be2335070efb37901eb73846849da838')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:497', @guest_id, 'Guest', 'Imported Record 0496', 'India', 'IN', 'Superior Double', 8, 'low', 12504, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0497', 'SE', 'Sweden', '53cbaa0399e667bdc7520c4489ef2835f12f4104f345788d7699415bc58b76db')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:498', @guest_id, 'Guest', 'Imported Record 0497', 'Sweden', 'SE', 'Junior Suite', 8, 'high', 19576, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0498', 'GB', 'United Kingdom', '66c874d0ffccd0a15bbf6b8d722a8cbd9ea76b4050c008252e2926708a4040ed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:499', @guest_id, 'Guest', 'Imported Record 0498', 'United Kingdom', 'GB', 'LOFT Suite', 3, 'high', 10515, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0499', 'NG', 'Nigeria', 'f994f5e178b28ced82d56cd44874ccf3da687690ce03d717f560369994cb3cbd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:500', @guest_id, 'Guest', 'Imported Record 0499', 'Nigeria', 'NG', 'Junior Suite', 6, 'low', 11712, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0500', 'IN', 'India', 'dfea454c8479b5cef1cd8a612e6f55b942c75a46fccb795f051ca7073032bc29')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:501', @guest_id, 'Guest', 'Imported Record 0500', 'India', 'IN', 'LOFT Suite', 5, 'low', 15530, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0501', 'AU', 'Australia', '5322ad5d2da8bee3f088af87861113826b6b319513e5c9453c6d82bb8c68953c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:502', @guest_id, 'Guest', 'Imported Record 0501', 'Australia', 'AU', 'Superior Double', 7, 'low', 10311, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0502', 'VN', 'Vietnam', '162678f7d1e2dc6f1a112e101beb8e9b430af79dc0f59abd46598179349bebf3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:503', @guest_id, 'Guest', 'Imported Record 0502', 'Vietnam', 'VN', 'Standard Single', 6, 'high', 7326, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0503', 'IT', 'Italy', '6a08399c9e9241cb4b2cd90b19719da8719781d4932767725bf3c7a808fbfbbd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:504', @guest_id, 'Guest', 'Imported Record 0503', 'Italy', 'IT', 'Superior Double', 4, 'mid', 7032, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0504', 'ES', 'Spain', 'f6c6b84b90466e6ab73260fc8419b5b577f9247ea1ae262b1b550aa0aa971918')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:505', @guest_id, 'Guest', 'Imported Record 0504', 'Spain', 'ES', 'Junior Suite', 1, 'high', 2397, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0505', 'NG', 'Nigeria', 'b7660a9311be26202a4b9ee10d20320b39da7ea8fd6f1ebfbdcb473491df3c2d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:506', @guest_id, 'Guest', 'Imported Record 0505', 'Nigeria', 'NG', 'Spa Executive', 8, 'low', 16376, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0506', 'CA', 'Canada', '575868b47b295826164007971a08348379c3ee68e075d135d71028699272a750')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:507', @guest_id, 'Guest', 'Imported Record 0506', 'Canada', 'CA', 'Standard Single', 9, 'low', 8280, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0507', 'NG', 'Nigeria', 'b94f3c4d5810098d5a861e9e462386c49254b5af3503f03a4cb27408f7f852ed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:508', @guest_id, 'Guest', 'Imported Record 0507', 'Nigeria', 'NG', 'Spa Executive', 1, 'high', 2597, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0508', 'BR', 'Brazil', '24512028025825f6903df5f687f684017b31194f91865ec070f33f831430e27d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:509', @guest_id, 'Guest', 'Imported Record 0508', 'Brazil', 'BR', 'Junior Suite', 6, 'high', 14706, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0509', 'ES', 'Spain', '25538901c2fafd079191b1f654c31383d8e0f1392fab56b56df6e4e387ae0125')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:510', @guest_id, 'Guest', 'Imported Record 0509', 'Spain', 'ES', 'Standard Double', 10, 'high', 17770, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0510', 'US', 'United States', '350df7c3095197b02839af7229fa3441b296729747ea7b149776c27a4afb76e1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:511', @guest_id, 'Guest', 'Imported Record 0510', 'United States', 'US', 'Suite', 1, 'low', 2610, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0511', 'KR', 'South Korea', 'd14ae856316d5656a887c798caefbb9743aff65c9e76584b956f32f7581e6ac3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:512', @guest_id, 'Guest', 'Imported Record 0511', 'South Korea', 'KR', 'Junior Suite', 10, 'low', 20590, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0512', 'KR', 'South Korea', '08df4b8a8784090cc4b38ba89219ee6161c1e227137594a553fec9512ac6259c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:513', @guest_id, 'Guest', 'Imported Record 0512', 'South Korea', 'KR', 'LOFT Suite', 5, 'high', 19275, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0513', 'GB', 'United Kingdom', '9775dae964b67de480c7e4eba0a326d676ff1482867c7cc083910228c23dfc2b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:514', @guest_id, 'Guest', 'Imported Record 0513', 'United Kingdom', 'GB', 'Spa Executive', 8, 'high', 20560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0514', 'AU', 'Australia', '163aceb81b1f7f0a106b3569004bee6ab56faa0ef699972b01697aea54a85020')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:515', @guest_id, 'Guest', 'Imported Record 0514', 'Australia', 'AU', 'Spa Executive', 5, 'mid', 11830, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0515', 'JP', 'Japan', '7a545925dbd42361b7636f8ea8e32c72c398f0fc8cb29103e7b432e8f19b53e5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:516', @guest_id, 'Guest', 'Imported Record 0515', 'Japan', 'JP', 'Standard Single', 7, 'high', 9051, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0516', 'VN', 'Vietnam', '5dd2a6e7b480c94600ec69f4bf34abdd98776735b1c12e5ff805e4ec905651ca')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:517', @guest_id, 'Guest', 'Imported Record 0516', 'Vietnam', 'VN', 'LOFT Suite', 8, 'high', 28144, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0517', 'SE', 'Sweden', 'edfa4b7ceb8a34fd4172c776efbeb964dbb2f4be2ac3311591aec2a7c4ba0e7b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:518', @guest_id, 'Guest', 'Imported Record 0517', 'Sweden', 'SE', 'Suite', 10, 'low', 25470, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0518', 'RU', 'Russia', '77cb88e962218d17ee0fa42d807dab8a2cb58a57f3f40b9b18ec31c43348f3f4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:519', @guest_id, 'Guest', 'Imported Record 0518', 'Russia', 'RU', 'Standard Single', 3, 'mid', 3021, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0519', 'VN', 'Vietnam', '42652710ff23895e23ec135b7e6f35380958e506f97be88f09037331f958aa13')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:520', @guest_id, 'Guest', 'Imported Record 0519', 'Vietnam', 'VN', 'Suite', 10, 'low', 29370, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0520', 'IN', 'India', 'e1f127d1ce3fa6fbec8f08b6f307c691a4a4126d4a2cca4bbbc435f2106fae5e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:521', @guest_id, 'Guest', 'Imported Record 0520', 'India', 'IN', 'Standard Double', 3, 'mid', 5031, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0521', 'CA', 'Canada', '11a5686e7894cd32a75dab7453ef04780a069fe6b1908046a6e91de0c9831c81')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:522', @guest_id, 'Guest', 'Imported Record 0521', 'Canada', 'CA', 'Suite', 10, 'low', 27750, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0522', 'GB', 'United Kingdom', '41583bc023c11a0a0e9e299869ca7e60a7a5bbf1fb8882833506344540e6bd25')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:523', @guest_id, 'Guest', 'Imported Record 0522', 'United Kingdom', 'GB', 'Junior Suite', 4, 'low', 8692, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0523', 'FR', 'France', '12e741e33e3069dd219f63008cd99a5bd3dbe3f2325c2c60d2281edaf198a24b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:524', @guest_id, 'Guest', 'Imported Record 0523', 'France', 'FR', 'Grand Lit', 2, 'low', 2606, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0524', 'CN', 'China', 'c3b0924d274d7ad11044c0b3b762a94e02675401ce8061e0d69af21ebb159fda')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:525', @guest_id, 'Guest', 'Imported Record 0524', 'China', 'CN', 'Spa Executive', 5, 'low', 11150, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0525', 'IN', 'India', '73a7e882fe6179346b3a1a1026de1b9c1f0047af23232772970cbb4841124e96')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:526', @guest_id, 'Guest', 'Imported Record 0525', 'India', 'IN', 'Superior Double', 8, 'low', 12864, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0526', 'MX', 'Mexico', 'a1c1d5165f76727176e16b1e85c7d2abe0a8dc3faf1c14fe9703593e9334e7b8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:527', @guest_id, 'Guest', 'Imported Record 0526', 'Mexico', 'MX', 'Junior Suite', 3, 'mid', 6633, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0527', 'MX', 'Mexico', '2bbf962aa07a8a7ac980568b8c0821e9f14a0a7b2f3935de93dc81a6c8f6d658')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:528', @guest_id, 'Guest', 'Imported Record 0527', 'Mexico', 'MX', 'Spa Executive', 3, 'mid', 7404, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0528', 'DE', 'Germany', '0059b549d84bf1288a3a4050ed3971cac32bef741724416402ef310019b2ab4a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:529', @guest_id, 'Guest', 'Imported Record 0528', 'Germany', 'DE', 'Spa Executive', 9, 'low', 20295, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0529', 'SE', 'Sweden', '0d0878a8883a5bf1c463feb568d0f82b442134e925dfb253c3326cc90580bdba')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:530', @guest_id, 'Guest', 'Imported Record 0529', 'Sweden', 'SE', 'LOFT Suite', 10, 'high', 39450, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0530', 'BR', 'Brazil', 'aa9dd514dd8807068392bcbf3e446f22354f587e061864363589ff7f623319c1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:531', @guest_id, 'Guest', 'Imported Record 0530', 'Brazil', 'BR', 'Suite', 7, 'low', 19558, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0531', 'GB', 'United Kingdom', '2a0f01b2bd17e9639c0c664880827e6b7c944fefb7ef5042e910a1afb0825b37')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:532', @guest_id, 'Guest', 'Imported Record 0531', 'United Kingdom', 'GB', 'Suite', 8, 'high', 24032, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0532', 'AU', 'Australia', '6ffd4d0d82b893dfff88f1915b87b239c80774ad2fb3fed3ec611e7ec015216f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:533', @guest_id, 'Guest', 'Imported Record 0532', 'Australia', 'AU', 'Standard Double', 1, 'high', 1838, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0533', 'EG', 'Egypt', '2dc3da3c4afacf87df87c24dea27ec93ccd253e158415b73779143d82254f92a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:534', @guest_id, 'Guest', 'Imported Record 0533', 'Egypt', 'EG', 'Suite', 3, 'mid', 9603, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0534', 'NG', 'Nigeria', '1104ef388b10b31a5c42f8cc63ba545f957d53331bc13ccef529f61b6f13b76e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:535', @guest_id, 'Guest', 'Imported Record 0534', 'Nigeria', 'NG', 'Spa Executive', 5, 'high', 12720, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0535', 'MX', 'Mexico', '089ad304ef767e41b073ee7f1cf25ce2b28f96ac4c8eb737a63bb546b40fbeaf')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:536', @guest_id, 'Guest', 'Imported Record 0535', 'Mexico', 'MX', 'Suite', 5, 'high', 16845, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0536', 'IT', 'Italy', '705a7fa943a3249ce5dd2b7283135ef29e00cc83dc7b18ee9fee75fa5fe57cd0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:537', @guest_id, 'Guest', 'Imported Record 0536', 'Italy', 'IT', 'LOFT Suite', 4, 'high', 14504, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0537', 'GB', 'United Kingdom', 'c120e84acc667284136f7e11c73f6d6b598bd8ad4593e39a1151e269b424a0e5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:538', @guest_id, 'Guest', 'Imported Record 0537', 'United Kingdom', 'GB', 'Spa Executive', 10, 'low', 20280, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0538', 'IN', 'India', '3c946fe8c68f4e98442437dc52df26031486a7422cd40af0363994af841ec1eb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:539', @guest_id, 'Guest', 'Imported Record 0538', 'India', 'IN', 'Superior Double', 5, 'high', 10005, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0539', 'ES', 'Spain', 'adb7f1ddca8abed099fcdb59314ced6a440195d73febb8dc442a241e51e6cf8d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:540', @guest_id, 'Guest', 'Imported Record 0539', 'Spain', 'ES', 'Junior Suite', 8, 'mid', 18696, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0540', 'CA', 'Canada', 'b22852f65c99699f604ad41197977ae4fcef2bb311e27748041b5bafb503be48')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:541', @guest_id, 'Guest', 'Imported Record 0540', 'Canada', 'CA', 'Superior Double', 5, 'high', 10260, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0541', 'IT', 'Italy', 'eb33fb95a3eee226d505fbd99ee44101f0d64e569140c32758ba00ef1467d2ec')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:542', @guest_id, 'Guest', 'Imported Record 0541', 'Italy', 'IT', 'Standard Single', 6, 'mid', 6156, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0542', 'NG', 'Nigeria', '503bbf5be83595e26d5c5a9715f777065b9854dff486be86552aa57c4b7b3487')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:543', @guest_id, 'Guest', 'Imported Record 0542', 'Nigeria', 'NG', 'Superior Double', 3, 'mid', 5748, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0543', 'ES', 'Spain', '6045654e5601b2a85969bd1cb05394e17b935b3dce33835b7a8e2b7c7b30006e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:544', @guest_id, 'Guest', 'Imported Record 0543', 'Spain', 'ES', 'Spa Executive', 7, 'low', 16646, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0544', 'SE', 'Sweden', '06c827cc85c3f4d52ddf4871e79011c401de164843bf185f9aae5171d119ee62')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:545', @guest_id, 'Guest', 'Imported Record 0544', 'Sweden', 'SE', 'Grand Lit', 6, 'low', 6828, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0545', 'US', 'United States', 'dd65a1a27cc9078783689f26a35cd4ec48b5004835c9bd7493dafcddd4d6e9c9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:546', @guest_id, 'Guest', 'Imported Record 0545', 'United States', 'US', 'Junior Suite', 8, 'high', 19048, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0546', 'US', 'United States', 'ee09fbf1e0c93f90a5ad7557d448e4016066a797985146291ef321c75eddb5c1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:547', @guest_id, 'Guest', 'Imported Record 0546', 'United States', 'US', 'Standard Single', 2, 'mid', 2206, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0547', 'IN', 'India', 'b2ce187dc084a47b2676b1e5a176c6bec14600b2c5e2672aa795e26893ecce76')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:548', @guest_id, 'Guest', 'Imported Record 0547', 'India', 'IN', 'Standard Single', 8, 'high', 10096, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0548', 'RU', 'Russia', '6ca27362fef224c6f15a4ca77ef5df4a93d5fbb088355f59ea3cb604fd90e08e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:549', @guest_id, 'Guest', 'Imported Record 0548', 'Russia', 'RU', 'LOFT Suite', 6, 'mid', 22218, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0549', 'CA', 'Canada', 'e6da8750c24bbe88943be9548bc9a1fcc5264a374e5365f98e228718830b84af')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:550', @guest_id, 'Guest', 'Imported Record 0549', 'Canada', 'CA', 'LOFT Suite', 7, 'low', 24241, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0550', 'AU', 'Australia', 'f6b6170abe65a09e376bf021ff462a6a8404ccfa5e820136c4978461edec527f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:551', @guest_id, 'Guest', 'Imported Record 0550', 'Australia', 'AU', 'Spa Executive', 8, 'high', 21496, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0551', 'JP', 'Japan', '75879c789c64fea9ba8712b52c6d5d0ae8c2169cc15a33e8881c54b4d5f7eca8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:552', @guest_id, 'Guest', 'Imported Record 0551', 'Japan', 'JP', 'Standard Single', 5, 'high', 6415, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0552', 'CA', 'Canada', '3a1680a34b3b68844d9c6afff701757ff1d5acfdf7e028fe43412364cb2d2ac0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:553', @guest_id, 'Guest', 'Imported Record 0552', 'Canada', 'CA', 'Junior Suite', 9, 'high', 21150, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0553', 'SE', 'Sweden', '0588813c949bdc4c56aa5a2d4e284d047b528dcfff04c627eacbaff0909cc8a2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:554', @guest_id, 'Guest', 'Imported Record 0553', 'Sweden', 'SE', 'Standard Double', 4, 'high', 7420, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0554', 'GB', 'United Kingdom', '22eb674eca6dba993a61a0ee5e582e44ba56e7ad015581f8162537db89ecf6a9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:555', @guest_id, 'Guest', 'Imported Record 0554', 'United Kingdom', 'GB', 'Grand Lit', 7, 'mid', 8624, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0555', 'BR', 'Brazil', 'b71c203c4873b10c32f386f879176ef5ddd1d1f516319b987b643ba76b84365b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:556', @guest_id, 'Guest', 'Imported Record 0555', 'Brazil', 'BR', 'Superior Double', 2, 'mid', 3994, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0556', 'PK', 'Pakistan', '63cc8d0a525de25250cef7955d582f8f82f5fe486cb927783e73a4dc140e7020')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:557', @guest_id, 'Guest', 'Imported Record 0556', 'Pakistan', 'PK', 'LOFT Suite', 9, 'low', 27729, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0557', 'IN', 'India', '0d6412e97c0a38a636135ec089d31440ec6221fe07bffa6010117b4668911eed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:558', @guest_id, 'Guest', 'Imported Record 0557', 'India', 'IN', 'LOFT Suite', 3, 'low', 9027, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0558', 'VN', 'Vietnam', '6d0a1cfe484b49936daab5e732a6eeebb14538247a7b84308c678d1a6a804054')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:559', @guest_id, 'Guest', 'Imported Record 0558', 'Vietnam', 'VN', 'Superior Double', 6, 'low', 10746, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0559', 'NG', 'Nigeria', 'f5798f9329a6e10148beb8ba02b32abacf60752a1aaa8fd08d2f8d5d508f2dd0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:560', @guest_id, 'Guest', 'Imported Record 0559', 'Nigeria', 'NG', 'Suite', 8, 'low', 22160, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0560', 'EG', 'Egypt', '8ea0d658517ce81969361c5ee34894b2018649c0fbf3a8a7e2727abfb26700c5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:561', @guest_id, 'Guest', 'Imported Record 0560', 'Egypt', 'EG', 'Superior Double', 2, 'high', 4082, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0561', 'DE', 'Germany', '83f039b0310b1b901f8387bc7c73f907d5c8eca942b7a3446ffaae2ad6d0d886')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:562', @guest_id, 'Guest', 'Imported Record 0561', 'Germany', 'DE', 'Standard Double', 3, 'high', 5817, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0562', 'KR', 'South Korea', '3391fe2b0790834a086224bdc9e891ecce24b38a2eb65863a9c806c946c74d56')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:563', @guest_id, 'Guest', 'Imported Record 0562', 'South Korea', 'KR', 'Junior Suite', 3, 'high', 7149, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0563', 'ES', 'Spain', '985779ae9a36af1d37b77aec312527b13ad7bbf8af1efdfc8569052963f51504')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:564', @guest_id, 'Guest', 'Imported Record 0563', 'Spain', 'ES', 'Suite', 3, 'high', 9171, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0564', 'JP', 'Japan', '62b771ca2b6bf7a1cf622b83ba7ff9e4e2874149c8c56fe23e93019e70f940ea')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:565', @guest_id, 'Guest', 'Imported Record 0564', 'Japan', 'JP', 'Superior Double', 3, 'high', 5907, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0565', 'US', 'United States', '8a5f08a3f15c3590cb5e03aedb09cf93c6b37714c96b2444b8f9db8da9db5634')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:566', @guest_id, 'Guest', 'Imported Record 0565', 'United States', 'US', 'Standard Double', 8, 'mid', 10464, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0566', 'EG', 'Egypt', '0f1064e5bb77d098b280651e66be76f7f9b577c3032e742fa3d5fa4fabcac7ef')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:567', @guest_id, 'Guest', 'Imported Record 0566', 'Egypt', 'EG', 'Standard Double', 8, 'low', 12240, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0567', 'KR', 'South Korea', '4829668cf363fd88a9c56515f028f4e6200d469af563944b5707df4dddc754dc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:568', @guest_id, 'Guest', 'Imported Record 0567', 'South Korea', 'KR', 'Suite', 10, 'mid', 31110, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0568', 'AU', 'Australia', 'fa8def1aaea91ee158f223b6b81ac3296c6d04ba56de5b0e20739e1951ac5928')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:569', @guest_id, 'Guest', 'Imported Record 0568', 'Australia', 'AU', 'Standard Double', 7, 'mid', 10584, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0569', 'KR', 'South Korea', '5b190740eef22808190ece4e50486015120ca459f8423fb4ed515f7a9e107e1f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:570', @guest_id, 'Guest', 'Imported Record 0569', 'South Korea', 'KR', 'Spa Executive', 4, 'mid', 9000, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0570', 'BR', 'Brazil', '6200223e096ca5284b15b5078fdcbc20bee122b0fe5ab21bf37c6e298a966e46')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:571', @guest_id, 'Guest', 'Imported Record 0570', 'Brazil', 'BR', 'Spa Executive', 7, 'high', 19446, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0571', 'SE', 'Sweden', '5855ac83d1fe2b01958067c9ee80bc48050afdc4d18888e866eaa11c94ca3c42')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:572', @guest_id, 'Guest', 'Imported Record 0571', 'Sweden', 'SE', 'Standard Single', 4, 'mid', 4688, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0572', 'FR', 'France', 'e44422292a37ff38e9062ac8a7e9bc18061432cbd959ecb4252cc31c9ba0860d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:573', @guest_id, 'Guest', 'Imported Record 0572', 'France', 'FR', 'Spa Executive', 4, 'mid', 9844, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0573', 'US', 'United States', '194b41483e89944f1714b89add2aba508a6939bfcc1738559ce02828558733be')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:574', @guest_id, 'Guest', 'Imported Record 0573', 'United States', 'US', 'Standard Double', 1, 'high', 1936, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0574', 'MX', 'Mexico', 'a13ac502531233427b91e69eba42d71d8eec368a62afde223b569adb1cab82f2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:575', @guest_id, 'Guest', 'Imported Record 0574', 'Mexico', 'MX', 'Suite', 10, 'high', 31530, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0575', 'VN', 'Vietnam', '40f10aea47f4ca4b85a64f953b31f1219b6ac785b7dfb47ce3d965bb8e1fee59')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:576', @guest_id, 'Guest', 'Imported Record 0575', 'Vietnam', 'VN', 'Superior Double', 9, 'mid', 17424, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0576', 'DE', 'Germany', '61c333d34d57610870017c57358353b770746a24eb574a4e4a8494648a480f01')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:577', @guest_id, 'Guest', 'Imported Record 0576', 'Germany', 'DE', 'Standard Double', 9, 'low', 11871, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0577', 'KR', 'South Korea', 'a930893ca709b2d328051399a861047287205576556f8e54620bda01a0cc7e6c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:578', @guest_id, 'Guest', 'Imported Record 0577', 'South Korea', 'KR', 'Standard Double', 8, 'low', 11552, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0578', 'BR', 'Brazil', '75927cf2147113c46cc2ff43dbacc1972c06a3f27744bf8b5d9d3a3cb219aa35')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:579', @guest_id, 'Guest', 'Imported Record 0578', 'Brazil', 'BR', 'Standard Single', 1, 'high', 1434, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0579', 'CN', 'China', '302a8f2e509ccd106bd5ab9797bdece9a608a38fe352b89e31e0b7ac2ef0bc57')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:580', @guest_id, 'Guest', 'Imported Record 0579', 'China', 'CN', 'LOFT Suite', 5, 'mid', 17655, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0580', 'ES', 'Spain', '88906cd5acf3145ce56397d176e90be43086fcf538637611882584bab611abab')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:581', @guest_id, 'Guest', 'Imported Record 0580', 'Spain', 'ES', 'Suite', 2, 'low', 5816, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0581', 'JP', 'Japan', '9fba572f1e3bde99328b3b5e1f83e563041933b88e688007ec811a03ad457979')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:582', @guest_id, 'Guest', 'Imported Record 0581', 'Japan', 'JP', 'Standard Double', 9, 'mid', 13500, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0582', 'ES', 'Spain', '3e9e7ab8359802899d31a7c33487d07dae2a54214e877d6b099065f0eb52edd7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:583', @guest_id, 'Guest', 'Imported Record 0582', 'Spain', 'ES', 'Standard Single', 4, 'high', 5756, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0583', 'CA', 'Canada', '689c9f03f509a8bb7a2be2968c5ddb8348193a0d2d9745db1515a05016ec522b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:584', @guest_id, 'Guest', 'Imported Record 0583', 'Canada', 'CA', 'Standard Double', 5, 'high', 8245, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0584', 'SE', 'Sweden', 'f4ba84b578a2d6fc18bb5edfb2759966ece758d91c23fdc6afb2156bb8ae5c1e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:585', @guest_id, 'Guest', 'Imported Record 0584', 'Sweden', 'SE', 'Standard Single', 4, 'mid', 4208, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0585', 'VN', 'Vietnam', '9108e953000732e8895958e69cce3a9b4ec3d0d408f489a1872067ba3a0f17c6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:586', @guest_id, 'Guest', 'Imported Record 0585', 'Vietnam', 'VN', 'LOFT Suite', 3, 'high', 11844, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0586', 'RU', 'Russia', '550bba9dab51760e8be34ad2e4cefdf97506eea6f5ace3f1b925c5a2e287e6a1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:587', @guest_id, 'Guest', 'Imported Record 0586', 'Russia', 'RU', 'Spa Executive', 3, 'mid', 7020, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0587', 'KR', 'South Korea', 'f69468fa353d2203c6d04d36d2aead2bfa9272a0a2a5a01b70d1833023e1d066')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:588', @guest_id, 'Guest', 'Imported Record 0587', 'South Korea', 'KR', 'Standard Single', 8, 'low', 8160, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0588', 'CN', 'China', '24c193c5ee9ed1856fa08c2811f2407d747f5792f0091464087c26f5499fb5fa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:589', @guest_id, 'Guest', 'Imported Record 0588', 'China', 'CN', 'Standard Single', 10, 'low', 9240, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0589', 'CA', 'Canada', 'fa296cc8a11ae5482a94638fc962f7cd1930ea996768e0884bd7f082dafa254f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:590', @guest_id, 'Guest', 'Imported Record 0589', 'Canada', 'CA', 'Suite', 6, 'low', 17916, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0590', 'PK', 'Pakistan', '90651122123319a3e5bfe412de5dcc2fe7fdf798bc3d02e954b6fb4aa6546d4d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:591', @guest_id, 'Guest', 'Imported Record 0590', 'Pakistan', 'PK', 'Junior Suite', 9, 'high', 22176, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0591', 'DE', 'Germany', 'be2603f9459b09722fb6f9eb05b0ccf591815c486a51fcc90e27ab0831c40098')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:592', @guest_id, 'Guest', 'Imported Record 0591', 'Germany', 'DE', 'Spa Executive', 10, 'mid', 24560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0592', 'AU', 'Australia', 'f623a2d1fd4f8a326c9daba6e7db77e870fdaf8314d6435e02d6dea54322eedb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:593', @guest_id, 'Guest', 'Imported Record 0592', 'Australia', 'AU', 'Superior Double', 9, 'mid', 14229, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0593', 'IN', 'India', 'b8da42eb91b3e1e06ecab8da9c57575dc59d1b9b7f560ed9a8bb7a71d16c4f7b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:594', @guest_id, 'Guest', 'Imported Record 0593', 'India', 'IN', 'Junior Suite', 1, 'low', 1886, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0594', 'US', 'United States', '1d143e17f775df4464a899e66853f1dd31eb7869a0362dd686393e2bbd7232f6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:595', @guest_id, 'Guest', 'Imported Record 0594', 'United States', 'US', 'Superior Double', 4, 'high', 7740, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0595', 'CA', 'Canada', '87300e18d7368cfa6ba1d51bca35387f5f9fb282bd87a375d63038e3ce4d5005')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:596', @guest_id, 'Guest', 'Imported Record 0595', 'Canada', 'CA', 'Standard Single', 3, 'mid', 3027, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0596', 'AU', 'Australia', '3f18fc6b4ea5b9ced76e69b8299b58203b05f99e8ab2831af54c8939de334d14')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:597', @guest_id, 'Guest', 'Imported Record 0596', 'Australia', 'AU', 'Spa Executive', 7, 'high', 18417, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0597', 'IN', 'India', '4d2e97de616d40c242f2c5def99f90e33310dd27a11b85b6922278e48facfcd0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:598', @guest_id, 'Guest', 'Imported Record 0597', 'India', 'IN', 'Grand Lit', 4, 'high', 6060, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0598', 'DE', 'Germany', '7603c857aee19769b63d54808c198a8c90580f398ed896ac2805ed750f494a72')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:599', @guest_id, 'Guest', 'Imported Record 0598', 'Germany', 'DE', 'Standard Single', 2, 'low', 2212, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0599', 'US', 'United States', '309656bdef3b4e6a220a6f58509fbc194baecfa426d295b1c92b27f0b2d1a4f7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:600', @guest_id, 'Guest', 'Imported Record 0599', 'United States', 'US', 'Junior Suite', 4, 'mid', 8640, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0600', 'IT', 'Italy', 'c089306f7af82c944ca69a1cc7a3e3cb1432b54dfc52922a0ff8cc0ea7ff269a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:601', @guest_id, 'Guest', 'Imported Record 0600', 'Italy', 'IT', 'LOFT Suite', 2, 'low', 6712, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0601', 'ES', 'Spain', '0eac6fb5531d2642d402e272330d3ced0c88eb7f252c08e4fe53aa733505754d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:602', @guest_id, 'Guest', 'Imported Record 0601', 'Spain', 'ES', 'Spa Executive', 10, 'mid', 24170, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0602', 'GB', 'United Kingdom', '6c926810cc7edfc3b24b8ef9e97da941b0b09dfcf23d2a3dbf4943b430f67eeb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:603', @guest_id, 'Guest', 'Imported Record 0602', 'United Kingdom', 'GB', 'Grand Lit', 9, 'low', 10008, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0603', 'BR', 'Brazil', 'aa2a3df4c5b4526b51442b0d82b7ca7c4a6504d2e42e28f7dca6e10762cbde34')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:604', @guest_id, 'Guest', 'Imported Record 0603', 'Brazil', 'BR', 'Standard Double', 8, 'mid', 11208, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0604', 'SE', 'Sweden', '290643df42e8381f6804963ce186a180614347ea662acf97fae548e3d51fbcdb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:605', @guest_id, 'Guest', 'Imported Record 0604', 'Sweden', 'SE', 'Superior Double', 6, 'high', 11496, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0605', 'DE', 'Germany', '152dc161f36dabc447704d60a085527fe112c3333954acf3258c12eca88836aa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:606', @guest_id, 'Guest', 'Imported Record 0605', 'Germany', 'DE', 'Superior Double', 4, 'high', 7824, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0606', 'VN', 'Vietnam', '5a43dda559edc609c54965ed40727c7e5c5e2f708f89e5f6019e8730f8e38884')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:607', @guest_id, 'Guest', 'Imported Record 0606', 'Vietnam', 'VN', 'Junior Suite', 9, 'mid', 18594, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0607', 'CN', 'China', '1e294942b3d47d8894c11f22385d9dfa239769901b76afa0c41710bf7618ba76')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:608', @guest_id, 'Guest', 'Imported Record 0607', 'China', 'CN', 'Junior Suite', 5, 'mid', 10475, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0608', 'IN', 'India', '03b6dee4426feb19859e6baf04c21843afb8c417a046930851eeed6d030b463c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:609', @guest_id, 'Guest', 'Imported Record 0608', 'India', 'IN', 'Standard Single', 2, 'mid', 2596, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0609', 'CA', 'Canada', '59041d7b30bee9453f17f0fb172500890478f9e7667c4fd612db52099a1b1865')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:610', @guest_id, 'Guest', 'Imported Record 0609', 'Canada', 'CA', 'LOFT Suite', 1, 'high', 3739, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0610', 'VN', 'Vietnam', '0e6097aa01281101ce8fcb4271fb9d1717e251312b984e83910c250378d873c4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:611', @guest_id, 'Guest', 'Imported Record 0610', 'Vietnam', 'VN', 'Grand Lit', 7, 'mid', 10724, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0611', 'FR', 'France', '9bb4ecd61931f84d5f483b08ccaebc74b31d6367ad68e70ad05be7b6ec00d838')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:612', @guest_id, 'Guest', 'Imported Record 0611', 'France', 'FR', 'Suite', 7, 'low', 19432, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0612', 'VN', 'Vietnam', '56290d9a2ac4b47c7f51785a9dec6adf5ba2215a9a541489cb6664bfd33298a5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:613', @guest_id, 'Guest', 'Imported Record 0612', 'Vietnam', 'VN', 'Standard Single', 6, 'low', 6660, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0613', 'SE', 'Sweden', 'a49c82328a7556ffeea009b6fcdcece1188cd49e70bfd9e9407a0d35d6c4bdd7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:614', @guest_id, 'Guest', 'Imported Record 0613', 'Sweden', 'SE', 'Suite', 3, 'high', 9555, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0614', 'RU', 'Russia', 'cb5fdeb3b455d8410040dfd5d4c681953563f707b2b36d03e9b3e80eceadb102')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:615', @guest_id, 'Guest', 'Imported Record 0614', 'Russia', 'RU', 'LOFT Suite', 1, 'high', 3598, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0615', 'RU', 'Russia', '006a96a93ba544aaf371d6c8f4ad86e5c90c243aaf60614ba445c971d883891a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:616', @guest_id, 'Guest', 'Imported Record 0615', 'Russia', 'RU', 'Superior Double', 7, 'low', 10052, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0616', 'PK', 'Pakistan', '71f6f1869f030fb6013b39624c3a7fa2780fc06e402a57008510f960e11d052d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:617', @guest_id, 'Guest', 'Imported Record 0616', 'Pakistan', 'PK', 'Grand Lit', 5, 'mid', 6090, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0617', 'US', 'United States', 'd3297a4a1207140a3cfd170995e0aae6c6d06fc7f307867c9e57888902f0fb08')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:618', @guest_id, 'Guest', 'Imported Record 0617', 'United States', 'US', 'Grand Lit', 2, 'low', 2384, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0618', 'VN', 'Vietnam', '1fbc1bda94f59a9f75f2472a7b9eb99e669be981a49f2a6cc2b318fbbd18c610')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:619', @guest_id, 'Guest', 'Imported Record 0618', 'Vietnam', 'VN', 'Suite', 9, 'low', 23958, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0619', 'CN', 'China', '1abd3b347d4e866d6cce3dffc5bb69519652b0d44574487331ccb8ae9d5a3b03')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:620', @guest_id, 'Guest', 'Imported Record 0619', 'China', 'CN', 'Suite', 2, 'mid', 6172, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0620', 'RU', 'Russia', 'adfb1ce95a78b02ec8f372e6e79fbedd918e9e974c0d79a77f25d2b08a08cade')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:621', @guest_id, 'Guest', 'Imported Record 0620', 'Russia', 'RU', 'Standard Single', 8, 'mid', 8152, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0621', 'SE', 'Sweden', '4ff5bfe1024831a776d806bf0c23617408003325ecd96f58abfd345b0ce578a4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:622', @guest_id, 'Guest', 'Imported Record 0621', 'Sweden', 'SE', 'Suite', 7, 'high', 23541, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0622', 'RU', 'Russia', '66578b5513d13910c7cc55c947fa9af1bd6e82667863927e883200a4cedd94b3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:623', @guest_id, 'Guest', 'Imported Record 0622', 'Russia', 'RU', 'Standard Double', 9, 'high', 15084, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0623', 'GB', 'United Kingdom', 'c1fd6fe02e92b4c55ffa59c66f98b75f7bf34276ba070907845f91e58965b3ee')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:624', @guest_id, 'Guest', 'Imported Record 0623', 'United Kingdom', 'GB', 'Spa Executive', 7, 'mid', 16576, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0624', 'FR', 'France', 'eda54ab88c35a256df162c34a20187fda804c1c47faaf915516e678e62b2fbca')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:625', @guest_id, 'Guest', 'Imported Record 0624', 'France', 'FR', 'Junior Suite', 4, 'mid', 8784, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0625', 'RU', 'Russia', '0651319ed1b3b7d1cf83159d23ab670bae7555957190f3f971675b6f46a482d4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:626', @guest_id, 'Guest', 'Imported Record 0625', 'Russia', 'RU', 'LOFT Suite', 1, 'low', 3094, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0626', 'KR', 'South Korea', '961abbf01d86db5d6ba735466acfff487bcbeba3008e4ae73c062bfd6788e4a3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:627', @guest_id, 'Guest', 'Imported Record 0626', 'South Korea', 'KR', 'Suite', 9, 'high', 27072, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0627', 'MX', 'Mexico', 'd1fd55752b25b456647f626b083fe906158cb2469aa916aaab220551071f56ff')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:628', @guest_id, 'Guest', 'Imported Record 0627', 'Mexico', 'MX', 'LOFT Suite', 6, 'high', 22974, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0628', 'CN', 'China', '89592edcb2f2ea3d3dcdcc84f765eb98ac0bede5cf2cc9adf158bcb8ee251a8a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:629', @guest_id, 'Guest', 'Imported Record 0628', 'China', 'CN', 'Grand Lit', 7, 'high', 11004, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0629', 'IT', 'Italy', '81fd2246e5d9cf7907afd5375fb5a4207ffb25a1dd3981f4705483c28507b2b9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:630', @guest_id, 'Guest', 'Imported Record 0629', 'Italy', 'IT', 'Superior Double', 10, 'high', 21110, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0630', 'BR', 'Brazil', '9c21d4d2a7fbf53f8c5001cd7e14f3ff8f66d1661605202c0331b254f8ca7f40')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:631', @guest_id, 'Guest', 'Imported Record 0630', 'Brazil', 'BR', 'Superior Double', 3, 'high', 5721, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0631', 'VN', 'Vietnam', 'ed333483be48824b365e96f4ea1e9c63bc186d5be05e3a309cf155ccc9f8cab6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:632', @guest_id, 'Guest', 'Imported Record 0631', 'Vietnam', 'VN', 'LOFT Suite', 2, 'low', 6208, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0632', 'IN', 'India', 'a079f64c1eb43031b8d31089e134729c44d7d542742cf6c149fc8f8731a2b3b3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:633', @guest_id, 'Guest', 'Imported Record 0632', 'India', 'IN', 'Standard Double', 8, 'low', 11544, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0633', 'IN', 'India', '49a23bb18643152a3b644d6c80ef770fcfa428f50792364d1c1ac34779077556')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:634', @guest_id, 'Guest', 'Imported Record 0633', 'India', 'IN', 'Standard Double', 4, 'low', 6356, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0634', 'VN', 'Vietnam', 'f0d879c32247507c4612961e31fc607d83a2950d5dc94b8e080f0de82cb2d4f9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:635', @guest_id, 'Guest', 'Imported Record 0634', 'Vietnam', 'VN', 'Grand Lit', 1, 'high', 1441, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0635', 'RU', 'Russia', '89dd9bbfa0b9235886b9d8e5dd56baff74b98dbb9e348cc968c80e98c21f9d2c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:636', @guest_id, 'Guest', 'Imported Record 0635', 'Russia', 'RU', 'Grand Lit', 9, 'low', 10629, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0636', 'ES', 'Spain', '91fffa755a91d5b6bbf0eab5d81a14714669a5cc2ccfb561e21fad8bb5283fa2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:637', @guest_id, 'Guest', 'Imported Record 0636', 'Spain', 'ES', 'Suite', 4, 'high', 13932, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0637', 'KR', 'South Korea', '13cf361ca0fdffc7afc86b4a2bd7032bd66c7e356ec15dcfa851bea04043e8d8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:638', @guest_id, 'Guest', 'Imported Record 0637', 'South Korea', 'KR', 'Grand Lit', 4, 'high', 6444, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0638', 'RU', 'Russia', 'a8d9c6a8ad04bf4b85bb6a1dce1efdf844b0ce2a57efc05dbfc55e430f74c491')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:639', @guest_id, 'Guest', 'Imported Record 0638', 'Russia', 'RU', 'Standard Single', 9, 'high', 11610, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0639', 'SE', 'Sweden', '0c9d7bdb44b3acac9e39d1ea5f4336f048e7de4b518595a812c9882b0ef3c84b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:640', @guest_id, 'Guest', 'Imported Record 0639', 'Sweden', 'SE', 'LOFT Suite', 1, 'mid', 3357, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0640', 'DE', 'Germany', '4c1439aa748f24d6e9672cdb97a3458c56cfeb1dc1ea76b39c9fff56cbb64700')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:641', @guest_id, 'Guest', 'Imported Record 0640', 'Germany', 'DE', 'Standard Double', 7, 'low', 10514, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0641', 'SE', 'Sweden', 'fa4675d683dad7789d8db0d487cccbf624898dc41547b50a7fffbff66349328f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:642', @guest_id, 'Guest', 'Imported Record 0641', 'Sweden', 'SE', 'LOFT Suite', 9, 'mid', 29547, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0642', 'FR', 'France', '2daa19003918386c0ef0aed54409a99c1bc483de5c7c2df838887e0f38d14f41')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:643', @guest_id, 'Guest', 'Imported Record 0642', 'France', 'FR', 'Superior Double', 4, 'high', 8256, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0643', 'SE', 'Sweden', '8bae1b245c1ea83bf079f1a5ed93588b31431264a936cff6011c41ca5da80b72')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:644', @guest_id, 'Guest', 'Imported Record 0643', 'Sweden', 'SE', 'Suite', 2, 'low', 5198, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0644', 'KR', 'South Korea', 'c3da6570fc743d2579cf4642dcb2146407ae8d3b2996dd429fd4f7c0a075325f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:645', @guest_id, 'Guest', 'Imported Record 0644', 'South Korea', 'KR', 'Standard Single', 10, 'mid', 11520, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0645', 'SE', 'Sweden', '37b1f4af3d3bd054ce5624b5e7b96364836953ba86b776e45ea8f542bda388f4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:646', @guest_id, 'Guest', 'Imported Record 0645', 'Sweden', 'SE', 'LOFT Suite', 2, 'high', 7506, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0646', 'KR', 'South Korea', '81ab4d276b4689711155935a5a11657e166838e86df330cedf54602627f37d47')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:647', @guest_id, 'Guest', 'Imported Record 0646', 'South Korea', 'KR', 'Spa Executive', 4, 'high', 10696, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0647', 'GB', 'United Kingdom', 'a993b9e7c50f5aeb04b9d180a03a0d16fd44dfa24e406af9db91ed428e72d0af')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:648', @guest_id, 'Guest', 'Imported Record 0647', 'United Kingdom', 'GB', 'Standard Double', 6, 'low', 8592, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0648', 'BR', 'Brazil', '215bc17a51bcdb307a8809cfa23eef1e72bd4f7ff56359e7e16c8f85bcc21265')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:649', @guest_id, 'Guest', 'Imported Record 0648', 'Brazil', 'BR', 'Superior Double', 2, 'high', 3926, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0649', 'US', 'United States', '4887879943db88234c3bd8bab2644bbaf3cfd9c511a88d1ff0f753d293a7a4b0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:650', @guest_id, 'Guest', 'Imported Record 0649', 'United States', 'US', 'Junior Suite', 8, 'low', 16344, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0650', 'IN', 'India', 'fb9fb56b8d87f9601a82ac642b259195feea2bc00cf625d58491e8a2be4104ed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:651', @guest_id, 'Guest', 'Imported Record 0650', 'India', 'IN', 'LOFT Suite', 6, 'mid', 22596, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0651', 'FR', 'France', '08f5b901b4cde9089e2851e76cba6f5bd7287141a7d7fe41b8e6a40cb458e142')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:652', @guest_id, 'Guest', 'Imported Record 0651', 'France', 'FR', 'LOFT Suite', 9, 'mid', 29286, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0652', 'IN', 'India', 'c762800225d0397258057ce2e654d0cbd843c2cb2d581a339bc174da5837676b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:653', @guest_id, 'Guest', 'Imported Record 0652', 'India', 'IN', 'Junior Suite', 4, 'low', 8004, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0653', 'CA', 'Canada', 'a341949c80d5335c9d26d4712c96b6e72d919925679734bef331d2488d46f253')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:654', @guest_id, 'Guest', 'Imported Record 0653', 'Canada', 'CA', 'Junior Suite', 8, 'mid', 16392, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0654', 'EG', 'Egypt', 'd3a79f301abf46ccbb8197c8d3062fed302c7c57649200a84d1b5526511dc7dd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:655', @guest_id, 'Guest', 'Imported Record 0654', 'Egypt', 'EG', 'Suite', 5, 'mid', 14425, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0655', 'ES', 'Spain', '432d0062c316f94d10c589ee502d64f4580bb72d13b807afd0a0c47e0ee963b7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:656', @guest_id, 'Guest', 'Imported Record 0655', 'Spain', 'ES', 'Standard Single', 10, 'low', 11160, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0656', 'US', 'United States', '107492b4df8744b4c51d3c03643a068009b0ebc5e40f401c6b9294d34dd2cd4e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:657', @guest_id, 'Guest', 'Imported Record 0656', 'United States', 'US', 'Spa Executive', 2, 'low', 4926, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0657', 'ES', 'Spain', '60963089349e730bd3fe97ab4a2f4f3f99b2d51808c766755e85e50d57414067')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:658', @guest_id, 'Guest', 'Imported Record 0657', 'Spain', 'ES', 'Suite', 7, 'low', 20531, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0658', 'DE', 'Germany', '022b0afcd12f3fd30257786e3cf8c9a3345c8643007f9186ae4dbb4da472e432')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:659', @guest_id, 'Guest', 'Imported Record 0658', 'Germany', 'DE', 'Standard Double', 8, 'high', 13496, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0659', 'CN', 'China', 'eb883e196e5e3089362643e3d1f38eed634e793c7b45c204e2c55921ad03ff10')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:660', @guest_id, 'Guest', 'Imported Record 0659', 'China', 'CN', 'Junior Suite', 10, 'low', 20140, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0660', 'KR', 'South Korea', '469bfd33e263ea0409b8abae8f1dc93963d6fb102bcf667a239a57d7d339dbf0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:661', @guest_id, 'Guest', 'Imported Record 0660', 'South Korea', 'KR', 'Grand Lit', 5, 'mid', 7570, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0661', 'CN', 'China', '98909d05f238c14677580271fbc6bf17fb9dce3f853ba20f2552cf15233f8483')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:662', @guest_id, 'Guest', 'Imported Record 0661', 'China', 'CN', 'Superior Double', 6, 'mid', 9066, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0662', 'FR', 'France', '08703ddbce4fc4cccbb2085f048c6cd9420b5fe57b9bcd1b18791cca9622d350')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:663', @guest_id, 'Guest', 'Imported Record 0662', 'France', 'FR', 'Spa Executive', 1, 'low', 2087, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0663', 'MX', 'Mexico', 'b044c81ddb6248cb7201036d852dc5f6c2a704e92d5ce7b5f8b79b43d4abc4bd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:664', @guest_id, 'Guest', 'Imported Record 0663', 'Mexico', 'MX', 'Suite', 3, 'low', 7560, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0664', 'GB', 'United Kingdom', 'aba052793e4a446d0b35a527c665e3e6d895b0b413c47de2021cb1cddd381ab9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:665', @guest_id, 'Guest', 'Imported Record 0664', 'United Kingdom', 'GB', 'Grand Lit', 8, 'high', 12872, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0665', 'KR', 'South Korea', 'f96cb4c2d20db5f344e6eb754c1278b1f8497362b2e77e998b5c80f9647ac4f0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:666', @guest_id, 'Guest', 'Imported Record 0665', 'South Korea', 'KR', 'LOFT Suite', 2, 'high', 7062, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0666', 'FR', 'France', '630ab1fb1c2f5265c16c148f1f689bf88adfb0c3a334e2e018af315f708277ac')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:667', @guest_id, 'Guest', 'Imported Record 0666', 'France', 'FR', 'Standard Single', 2, 'high', 2608, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0667', 'CA', 'Canada', 'a3853d4f29a7e3e5f4e55ab55699cc24fb2c6ff135c164c5c57e7862677c4a0f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:668', @guest_id, 'Guest', 'Imported Record 0667', 'Canada', 'CA', 'Standard Single', 9, 'low', 9531, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0668', 'US', 'United States', '88c0eabc2ac276083a916ad5a51fcef2e41f2187b73892bc298bafc3befc03bc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:669', @guest_id, 'Guest', 'Imported Record 0668', 'United States', 'US', 'Standard Double', 9, 'low', 11070, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0669', 'MX', 'Mexico', '769c1e92c55e244605a9d4ab9ca509c9a3a0a2821dbe51b720990b98ded4fdf2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:670', @guest_id, 'Guest', 'Imported Record 0669', 'Mexico', 'MX', 'Spa Executive', 1, 'mid', 2446, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0670', 'AU', 'Australia', '719a577b195eba4c15794bd50d3d67811e47937ea71ce6d6dc0cf95862d2cdc5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:671', @guest_id, 'Guest', 'Imported Record 0670', 'Australia', 'AU', 'Spa Executive', 4, 'low', 9288, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0671', 'CN', 'China', 'b7fa5a69f9eba1dda9163d67328e9fc454433a31894165a7c725c99973e8bafa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:672', @guest_id, 'Guest', 'Imported Record 0671', 'China', 'CN', 'Superior Double', 9, 'mid', 15291, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0672', 'ES', 'Spain', 'b0f33b4dcef45355aeed2452a132b1ff6178e10509e905ed0fbfb7505a9ec9d3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:673', @guest_id, 'Guest', 'Imported Record 0672', 'Spain', 'ES', 'Suite', 4, 'low', 10792, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0673', 'DE', 'Germany', 'd17ef41fbe09e2f3fbe1bc25349003ce901708cce7702dde6579e336ff42b60c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:674', @guest_id, 'Guest', 'Imported Record 0673', 'Germany', 'DE', 'Suite', 2, 'mid', 6452, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0674', 'AU', 'Australia', 'bfb77e12dd5a232cd3b76dd71488f2570e57c5a862abf8b1dd9be31812fadaae')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:675', @guest_id, 'Guest', 'Imported Record 0674', 'Australia', 'AU', 'Spa Executive', 6, 'mid', 14532, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0675', 'FR', 'France', 'ccb9284734deb68e71e03af53d88c6f52c1933a7a8ca2ca826281b49c47c9b46')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:676', @guest_id, 'Guest', 'Imported Record 0675', 'France', 'FR', 'Superior Double', 8, 'low', 14120, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0676', 'ES', 'Spain', '79a94761bf66dddb8995e55ef3d5473283e7c6c6e02bd91353c375945531e65e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:677', @guest_id, 'Guest', 'Imported Record 0676', 'Spain', 'ES', 'Junior Suite', 6, 'mid', 13854, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0677', 'FR', 'France', 'c9dac3d30ad182f9ddcc6265682f126200825d830a07240e34a595866ccc60a0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:678', @guest_id, 'Guest', 'Imported Record 0677', 'France', 'FR', 'Junior Suite', 9, 'mid', 20268, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0678', 'KR', 'South Korea', 'bc4431405d379f9123733ff859c87bff9ebaa21173ad3dd95c00d48a79c8afc9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:679', @guest_id, 'Guest', 'Imported Record 0678', 'South Korea', 'KR', 'Spa Executive', 5, 'mid', 11860, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0679', 'KR', 'South Korea', '6d6b99e530cc384a063b7e83b2c417ed6fed9f2a7ddf2852e937cc6bedee9d0a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:680', @guest_id, 'Guest', 'Imported Record 0679', 'South Korea', 'KR', 'Suite', 8, 'mid', 22616, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0680', 'NG', 'Nigeria', '60ec6568f1eff22db855495d4165857b3a9f2efaca7e75c73e42cd41d75ffe9c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:681', @guest_id, 'Guest', 'Imported Record 0680', 'Nigeria', 'NG', 'Spa Executive', 8, 'high', 21816, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0681', 'NG', 'Nigeria', 'bea49ca19a5e7858697b1f083c402350e146d8a551bc2a9953b97233035e7bff')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:682', @guest_id, 'Guest', 'Imported Record 0681', 'Nigeria', 'NG', 'Spa Executive', 9, 'high', 22581, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0682', 'DE', 'Germany', '3c22745a7a5abf30ba413eb94ddde7ab2680ebfd084d821c5ba8b41b11d51d7e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:683', @guest_id, 'Guest', 'Imported Record 0682', 'Germany', 'DE', 'Standard Single', 10, 'mid', 11000, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0683', 'GB', 'United Kingdom', '2ce8706593928b71f1296d86c1b2647b27f276d115c840ec730a7c79dc1fe5ef')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:684', @guest_id, 'Guest', 'Imported Record 0683', 'United Kingdom', 'GB', 'Junior Suite', 7, 'mid', 15708, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0684', 'PK', 'Pakistan', 'f5b8b8b3da5f63e3e4dc134fd6538440d667f52f94c214199205f17767add418')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:685', @guest_id, 'Guest', 'Imported Record 0684', 'Pakistan', 'PK', 'Grand Lit', 3, 'low', 3885, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0685', 'JP', 'Japan', '308e7ca39b038184e6c4f3874ceb6a5caf61023a38f54712fd99d21f85475628')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:686', @guest_id, 'Guest', 'Imported Record 0685', 'Japan', 'JP', 'Junior Suite', 8, 'high', 18088, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0686', 'VN', 'Vietnam', '1480f2d2ef548de431cecb84737e43cb5036b547876c2ea6f33149be90823c27')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:687', @guest_id, 'Guest', 'Imported Record 0686', 'Vietnam', 'VN', 'Grand Lit', 2, 'low', 2288, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0687', 'FR', 'France', 'a35d7714f178bef94a492f7aedb4e8401bb52d652553cf6cf02df9f50d7fbe5a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:688', @guest_id, 'Guest', 'Imported Record 0687', 'France', 'FR', 'Superior Double', 6, 'high', 11022, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0688', 'FR', 'France', 'a91ef0c7c2b55a0d7f07c3178389dacc946aa08caa26880296c4b12c1aecf618')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:689', @guest_id, 'Guest', 'Imported Record 0688', 'France', 'FR', 'LOFT Suite', 10, 'mid', 36090, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0689', 'NG', 'Nigeria', 'a6d006b7496e7a187fbed63ad9c57629b75387144133bb69e8b78100a9a836ed')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:690', @guest_id, 'Guest', 'Imported Record 0689', 'Nigeria', 'NG', 'Spa Executive', 6, 'low', 12840, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0690', 'KR', 'South Korea', '851e486e8643648c532ba96332b4a98ad67ed1500540f34839e372291f67bfcd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:691', @guest_id, 'Guest', 'Imported Record 0690', 'South Korea', 'KR', 'Standard Double', 8, 'low', 12368, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0691', 'JP', 'Japan', '59f340af8ff1324fde78cd83a5454e2aea06b6254dae9099d4153929c1a8ecb1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:692', @guest_id, 'Guest', 'Imported Record 0691', 'Japan', 'JP', 'Suite', 2, 'high', 6496, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0692', 'BR', 'Brazil', 'fddac498d6f40cf089469be129a54a6dc875663c4e95f45ee5daf1f0b420f9b3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:693', @guest_id, 'Guest', 'Imported Record 0692', 'Brazil', 'BR', 'Junior Suite', 4, 'high', 9264, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0693', 'DE', 'Germany', '995a22a6dce97104afeccc06058f9ff4027535dcb19c54f60b14ef5cfc6b8af6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:694', @guest_id, 'Guest', 'Imported Record 0693', 'Germany', 'DE', 'Grand Lit', 5, 'high', 7430, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0694', 'IT', 'Italy', '5477e6ef10cc756e3f19452297de80079bf5db72dc944dcbdccae91eb0c65d09')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:695', @guest_id, 'Guest', 'Imported Record 0694', 'Italy', 'IT', 'Spa Executive', 8, 'high', 20624, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0695', 'RU', 'Russia', 'f3c73e6f9a8ead920a0256f0cc7f64da129990a84074e684b93bd24ce0021bb0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:696', @guest_id, 'Guest', 'Imported Record 0695', 'Russia', 'RU', 'Standard Double', 5, 'low', 6360, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0696', 'GB', 'United Kingdom', 'bbe2650bacd551a082579963b31085943583c01d02a6a4395e7d9ab224862a88')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:697', @guest_id, 'Guest', 'Imported Record 0696', 'United Kingdom', 'GB', 'Superior Double', 10, 'low', 15410, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0697', 'GB', 'United Kingdom', '0f5187a992f88a796c6bf256af3969e83429c5368be9526397f8b4ff728e7348')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:698', @guest_id, 'Guest', 'Imported Record 0697', 'United Kingdom', 'GB', 'Superior Double', 7, 'mid', 13832, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0698', 'SE', 'Sweden', '8276af66a3870e72e9ec6018fd6d00d843e53114c5d9d9e94124093bdc2da04b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:699', @guest_id, 'Guest', 'Imported Record 0698', 'Sweden', 'SE', 'Spa Executive', 1, 'low', 2102, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0699', 'FR', 'France', '20b50d1fd2aa2fc1617e73fbd33ae107f2c6a89385497a672a2ce5e8ffcdcbab')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:700', @guest_id, 'Guest', 'Imported Record 0699', 'France', 'FR', 'Superior Double', 8, 'low', 11976, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0700', 'GB', 'United Kingdom', '8ad71d1ec7a5f25715c2bfef6551dc00347dca2fc21714737b549e71bb02150a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:701', @guest_id, 'Guest', 'Imported Record 0700', 'United Kingdom', 'GB', 'Junior Suite', 10, 'mid', 21370, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0701', 'JP', 'Japan', '504b6c3030f274ee7a0bdf2b13db485b472d900c7992966eb813208119df4c78')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:702', @guest_id, 'Guest', 'Imported Record 0701', 'Japan', 'JP', 'Grand Lit', 10, 'low', 12490, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0702', 'CA', 'Canada', '2d1ea839f52cc6913c95116975701c50c2e51ca87b69c6f94a996ef1e4d85b66')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:703', @guest_id, 'Guest', 'Imported Record 0702', 'Canada', 'CA', 'Junior Suite', 1, 'mid', 2260, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0703', 'SE', 'Sweden', 'e16487fcd56c07a5d7f43a234ff0578168a0968926ed0f25afb65277bae0c178')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:704', @guest_id, 'Guest', 'Imported Record 0703', 'Sweden', 'SE', 'Spa Executive', 7, 'high', 18284, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0704', 'IT', 'Italy', 'd70a4b50aaa47664f3d27803d064eab97a9b06d03aa243ebfdd4ee124210b679')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:705', @guest_id, 'Guest', 'Imported Record 0704', 'Italy', 'IT', 'Spa Executive', 7, 'mid', 16163, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0705', 'IT', 'Italy', '0dd08f06424579271940ed36b521a602d40f0596b11de02ef4369fd560621d1a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:706', @guest_id, 'Guest', 'Imported Record 0705', 'Italy', 'IT', 'Superior Double', 8, 'low', 14248, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0706', 'EG', 'Egypt', 'e70758251c02af234422ba7f6bfe36621a490ff16ec72ba3dc379165f3b2df3a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:707', @guest_id, 'Guest', 'Imported Record 0706', 'Egypt', 'EG', 'Standard Double', 9, 'high', 15885, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0707', 'DE', 'Germany', 'ab15ca46a196a105fe206db20d72037a8e78ab0642b38fd6c618fda6f21fddea')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:708', @guest_id, 'Guest', 'Imported Record 0707', 'Germany', 'DE', 'LOFT Suite', 4, 'low', 13108, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0708', 'BR', 'Brazil', 'bf3db2107c06748aa276bcbf5b74568362ffe1dfc2a51c2ed9353c546720832b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:709', @guest_id, 'Guest', 'Imported Record 0708', 'Brazil', 'BR', 'Suite', 3, 'mid', 9030, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0709', 'IN', 'India', '7fde889df5218aafef6b2754a0584bb800f9f8e539a6d982c26bec078857eb49')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:710', @guest_id, 'Guest', 'Imported Record 0709', 'India', 'IN', 'Standard Single', 9, 'mid', 10278, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0710', 'MX', 'Mexico', '392904296634566b644dcf987eb48d618146f60b3694e69dcef29c6c09624ca6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:711', @guest_id, 'Guest', 'Imported Record 0710', 'Mexico', 'MX', 'Suite', 6, 'low', 15564, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0711', 'IT', 'Italy', '3fa0b5d36714a2dbfab11e3116b9734579c51e9ff40cfdc0cf6c47b9d6058367')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:712', @guest_id, 'Guest', 'Imported Record 0711', 'Italy', 'IT', 'Spa Executive', 6, 'high', 16326, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0712', 'EG', 'Egypt', 'ceab5ee32284f3bc8d117821bf5a85605c5b9898d68b83eb33641417f2e20442')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:713', @guest_id, 'Guest', 'Imported Record 0712', 'Egypt', 'EG', 'Standard Double', 2, 'low', 2646, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0713', 'IT', 'Italy', 'a585c3297e279fc2834e7e3e683f48f0965f9c52a9a187a9103c08dc81b94597')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:714', @guest_id, 'Guest', 'Imported Record 0713', 'Italy', 'IT', 'Superior Double', 5, 'mid', 7845, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0714', 'RU', 'Russia', '8ee5b2032b6261bc42204fa365ea64874b51c5095ff234dc53ee71bc188fed26')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:715', @guest_id, 'Guest', 'Imported Record 0714', 'Russia', 'RU', 'Suite', 2, 'high', 6592, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0715', 'BR', 'Brazil', '51035ae28ef7addf81dccd8660237f6d66ec3facdb97fbf6498407bd4b766632')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:716', @guest_id, 'Guest', 'Imported Record 0715', 'Brazil', 'BR', 'Junior Suite', 6, 'mid', 14322, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0716', 'RU', 'Russia', '1d70aafe6ff64f3532772de3d6cef3f320cb5ff208854db0d384add66fbf6eca')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:717', @guest_id, 'Guest', 'Imported Record 0716', 'Russia', 'RU', 'Junior Suite', 2, 'mid', 4028, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0717', 'PK', 'Pakistan', '568eb3b9e8785019f8ac76cd17dec7f5ee843f0575b8fedb772555c273b7b04d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:718', @guest_id, 'Guest', 'Imported Record 0717', 'Pakistan', 'PK', 'Grand Lit', 8, 'high', 14224, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0718', 'ES', 'Spain', 'e82768d7f244a8fcf99a8f08e13264cad594ac905206317b5bed139042116ba4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:719', @guest_id, 'Guest', 'Imported Record 0718', 'Spain', 'ES', 'LOFT Suite', 8, 'high', 28600, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0719', 'FR', 'France', 'f49f2c62a0b2c46020b42d539c7bb0f34eb1d31978181b6e7ee6d9066544b63d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:720', @guest_id, 'Guest', 'Imported Record 0719', 'France', 'FR', 'Suite', 10, 'low', 29710, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0720', 'KR', 'South Korea', 'b9a7cfaa6abca670f377481cf1ab1ae9f023da49205520ba7c7ef531dc98eb90')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:721', @guest_id, 'Guest', 'Imported Record 0720', 'South Korea', 'KR', 'Standard Single', 7, 'low', 6902, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0721', 'PK', 'Pakistan', '06097014478fa4b3b550f40143a5e06554ef043d029e6c6d86eec581b306d13b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:722', @guest_id, 'Guest', 'Imported Record 0721', 'Pakistan', 'PK', 'Standard Single', 6, 'mid', 6966, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0722', 'NG', 'Nigeria', '9c3b68ff2209055a1331b548e7ee73ffcfd99445663f0b565a3fb09ce7da615a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:723', @guest_id, 'Guest', 'Imported Record 0722', 'Nigeria', 'NG', 'Superior Double', 1, 'low', 1615, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0723', 'US', 'United States', '02184a0c5dcec164506ddc3d91ca636ef2999437248d93f00d08f51567d4a9d9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:724', @guest_id, 'Guest', 'Imported Record 0723', 'United States', 'US', 'Superior Double', 2, 'mid', 3566, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0724', 'GB', 'United Kingdom', 'f06a85276328d3d5a5c44d35df2e694faa3c8df803f7489670c8bda57397b5ad')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:725', @guest_id, 'Guest', 'Imported Record 0724', 'United Kingdom', 'GB', 'Grand Lit', 1, 'high', 1772, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0725', 'CN', 'China', '5b10ad1d58c55ffb90ff44ad243866441333ac0bc1ded392bd478ff811a70ee6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:726', @guest_id, 'Guest', 'Imported Record 0725', 'China', 'CN', 'Grand Lit', 7, 'low', 8883, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0726', 'AU', 'Australia', '9d4a99b0930369714b77a89e591a3e5591c6238ae508b4571635bd9b91a1367a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:727', @guest_id, 'Guest', 'Imported Record 0726', 'Australia', 'AU', 'Junior Suite', 9, 'high', 20925, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0727', 'GB', 'United Kingdom', '38a061446a5ffbb673df94db3238c481879317a731f170489a5ac7d6f3357e3a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:728', @guest_id, 'Guest', 'Imported Record 0727', 'United Kingdom', 'GB', 'Standard Double', 10, 'mid', 14690, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0728', 'DE', 'Germany', 'caa56833156f46611f43654b66166c13f1243fd6484cff50938c190244022827')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:729', @guest_id, 'Guest', 'Imported Record 0728', 'Germany', 'DE', 'Standard Double', 4, 'low', 5556, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0729', 'BR', 'Brazil', '55376c97cfee6defe10a8a4d27836765567cbb21d1f3013b23a9b9d71208d8f4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:730', @guest_id, 'Guest', 'Imported Record 0729', 'Brazil', 'BR', 'Suite', 9, 'mid', 27738, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0730', 'SE', 'Sweden', 'dabc5f8e40f87d837ffc973f7fb5e90252b82477b2ecb9883438ee1ff7444ee4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:731', @guest_id, 'Guest', 'Imported Record 0730', 'Sweden', 'SE', 'Junior Suite', 7, 'low', 14091, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0731', 'FR', 'France', 'bd0d44e3ede487398969711f8439a6b3cff1ba265dc7ee728f0e74d7c436af62')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:732', @guest_id, 'Guest', 'Imported Record 0731', 'France', 'FR', 'Superior Double', 5, 'mid', 9055, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0732', 'IT', 'Italy', '4fbc2c4d81b16f182498697114a24cf89f1d8b76e249691b10de3a04b78ab017')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:733', @guest_id, 'Guest', 'Imported Record 0732', 'Italy', 'IT', 'Superior Double', 7, 'mid', 13272, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0733', 'US', 'United States', 'a38d3518fece57a26588241079fdb0691c68b642bf083260c1931016c413a9bb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:734', @guest_id, 'Guest', 'Imported Record 0733', 'United States', 'US', 'Standard Double', 3, 'low', 4359, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0734', 'DE', 'Germany', 'c19115e9e606151797eb5b34eb6a53d46ea7a2a7641856384906513e36a90b9a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:735', @guest_id, 'Guest', 'Imported Record 0734', 'Germany', 'DE', 'Standard Double', 10, 'mid', 16540, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0735', 'CA', 'Canada', '7a150353b5963e84ef6e6098bdd08a3cd6a23fcc0b2d4eddd48cf7309709aa3c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:736', @guest_id, 'Guest', 'Imported Record 0735', 'Canada', 'CA', 'LOFT Suite', 2, 'high', 7188, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0736', 'GB', 'United Kingdom', 'fee8d8f4b7576a5e4f50862f8ac3d0ddee294edb9921d3cdb7f8d5f95a710941')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:737', @guest_id, 'Guest', 'Imported Record 0736', 'United Kingdom', 'GB', 'Spa Executive', 2, 'low', 4992, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0737', 'IN', 'India', '48d996e52c84fcc577787a9565e5016fc243fade7b75a3dbdeebb75d98e2e9eb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:738', @guest_id, 'Guest', 'Imported Record 0737', 'India', 'IN', 'LOFT Suite', 6, 'low', 19608, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0738', 'CN', 'China', '98f7013f5f695112869dafd9b5ee0752aa0dc03b7d5d9107cc6ef690c96d7975')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:739', @guest_id, 'Guest', 'Imported Record 0738', 'China', 'CN', 'Superior Double', 4, 'high', 7228, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0739', 'EG', 'Egypt', '96729308ec413fb139149a7143e60bde2f3198aa80a8dfc1ee138354d3afc9ba')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:740', @guest_id, 'Guest', 'Imported Record 0739', 'Egypt', 'EG', 'Junior Suite', 9, 'high', 21285, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0740', 'JP', 'Japan', '3d6ca7a65374457f7f797103b2432d484099666bdfcba33dc9ed600ce9640d0b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:741', @guest_id, 'Guest', 'Imported Record 0740', 'Japan', 'JP', 'Junior Suite', 2, 'high', 4780, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0741', 'AU', 'Australia', 'a2164444e20290eae70a81e19fc5fd47c6d4cbc2852c29b180905ff061278c15')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:742', @guest_id, 'Guest', 'Imported Record 0741', 'Australia', 'AU', 'Standard Single', 8, 'low', 9360, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0742', 'GB', 'United Kingdom', '78e671b48ec4e69823f1ee042298ec37ace624b657a957d7bff9d1dc65b120ee')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:743', @guest_id, 'Guest', 'Imported Record 0742', 'United Kingdom', 'GB', 'Spa Executive', 3, 'low', 6552, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0743', 'SE', 'Sweden', 'c91bfd7bfbee4d5a6aae5b6dc6e2a6364b589ff07db2bd44aaf32584e1d1338e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:744', @guest_id, 'Guest', 'Imported Record 0743', 'Sweden', 'SE', 'Grand Lit', 9, 'high', 13050, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0744', 'IT', 'Italy', 'f573d3694c3096cd8cf2e785fdac6e26862689b7a3f685ec941149e524f5f23a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:745', @guest_id, 'Guest', 'Imported Record 0744', 'Italy', 'IT', 'Standard Double', 10, 'high', 18920, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0745', 'CA', 'Canada', 'b1880d42b8e373b27341a159eb14e95595a77fbd05485fdfbe2e49d79a637bb8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:746', @guest_id, 'Guest', 'Imported Record 0745', 'Canada', 'CA', 'Standard Double', 6, 'mid', 9276, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0746', 'EG', 'Egypt', 'c6b8e13ba2f462ec3330e04e5d89ee750c5711fbcbec9fc1f8ab6edfd1e86206')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:747', @guest_id, 'Guest', 'Imported Record 0746', 'Egypt', 'EG', 'Junior Suite', 1, 'high', 2257, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0747', 'KR', 'South Korea', '7b061d9b2bc0a79e9a667da932c8318349532c76ce859b2bc228aac805ccd1dd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:748', @guest_id, 'Guest', 'Imported Record 0747', 'South Korea', 'KR', 'Standard Double', 5, 'low', 7565, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0748', 'FR', 'France', 'b5bda2477f5fcaeb02ca142aef6afcd3e71616d7373ff1a87846f365b9927892')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:749', @guest_id, 'Guest', 'Imported Record 0748', 'France', 'FR', 'LOFT Suite', 2, 'high', 7522, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0749', 'KR', 'South Korea', 'e8d1a0fe712f62009d52d6f99175780effd301528af3a7e9871d4fca5ed6f42f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:750', @guest_id, 'Guest', 'Imported Record 0749', 'South Korea', 'KR', 'Grand Lit', 5, 'mid', 6395, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0750', 'VN', 'Vietnam', '6b2d0d31746a4e1a58992c9e4ab9d440623c126a3d8665ddad48a01706efdd0c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:751', @guest_id, 'Guest', 'Imported Record 0750', 'Vietnam', 'VN', 'Suite', 1, 'mid', 3217, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0751', 'GB', 'United Kingdom', '318fc840296ea5314709257330d43adef5acea89f7a68fa806191787860c5f63')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:752', @guest_id, 'Guest', 'Imported Record 0751', 'United Kingdom', 'GB', 'LOFT Suite', 1, 'low', 3245, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0752', 'MX', 'Mexico', 'da722f73555f56c64715e0e65003e4fed1dcc5804e6ac28d2306b35f86d478bc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:753', @guest_id, 'Guest', 'Imported Record 0752', 'Mexico', 'MX', 'Suite', 1, 'low', 2951, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0753', 'MX', 'Mexico', 'bfec30be4aadbbf5e1277cfa19649bc743af43e9fd7ca8cec38614811677f2d9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:754', @guest_id, 'Guest', 'Imported Record 0753', 'Mexico', 'MX', 'Standard Double', 1, 'low', 1575, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0754', 'US', 'United States', 'd1fbb6b3bf07f2eef251987d42d319227ce86f8297c9f161823b7d58fe1e9036')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:755', @guest_id, 'Guest', 'Imported Record 0754', 'United States', 'US', 'Standard Double', 6, 'high', 10230, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0755', 'RU', 'Russia', 'c81d09631750d96d429caabae0ca92257443d31bc40562338be0bb02f04e03d1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:756', @guest_id, 'Guest', 'Imported Record 0755', 'Russia', 'RU', 'Standard Single', 8, 'high', 11672, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0756', 'US', 'United States', '0e9825e820b4223b8aa05f821642bddd56349c84a3c005f5190e2ef149a71353')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:757', @guest_id, 'Guest', 'Imported Record 0756', 'United States', 'US', 'Spa Executive', 9, 'mid', 23229, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0757', 'CA', 'Canada', 'bbd8484715ece41e9ba4bceb6520b62b1a37080cc5565a17b356578def3231bf')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:758', @guest_id, 'Guest', 'Imported Record 0757', 'Canada', 'CA', 'Junior Suite', 5, 'high', 11940, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0758', 'IN', 'India', '217ddc1a9b6861fca0fc82e861ae49ca036f86a25470c7cc47d6e31d7c40f0d9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:759', @guest_id, 'Guest', 'Imported Record 0758', 'India', 'IN', 'Junior Suite', 3, 'mid', 6489, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0759', 'US', 'United States', 'b531ca79b28f9012f7a51fdbec890d092706102bf8099c49bf7703f7cb6de72d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:760', @guest_id, 'Guest', 'Imported Record 0759', 'United States', 'US', 'Superior Double', 2, 'mid', 3194, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0760', 'VN', 'Vietnam', '43068a6bdf76d745dc72581062b9176d77fc1b2ea53811d4a7dc0855872cbc39')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:761', @guest_id, 'Guest', 'Imported Record 0760', 'Vietnam', 'VN', 'Standard Double', 1, 'mid', 1311, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0761', 'AU', 'Australia', 'feda041caeccb213d5f51e84996dd0ece738b5b87a0e9ddcaa0535f208ff7dc7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:762', @guest_id, 'Guest', 'Imported Record 0761', 'Australia', 'AU', 'Spa Executive', 8, 'mid', 19584, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0762', 'PK', 'Pakistan', '479ba46e764654e84b9da5d8a0f8fcfab01b1dc6f2daff0e1aece23338ff78e0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:763', @guest_id, 'Guest', 'Imported Record 0762', 'Pakistan', 'PK', 'Standard Double', 6, 'high', 11442, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0763', 'EG', 'Egypt', '8ac282639d465853d6146678498fe7ac71cfd5d0016a0e24511f3a26780127f2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:764', @guest_id, 'Guest', 'Imported Record 0763', 'Egypt', 'EG', 'Grand Lit', 9, 'low', 10089, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0764', 'GB', 'United Kingdom', '227a519a30b7ea179759386556ec296f8c375a2b34508bd87c3e7a06595403d3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:765', @guest_id, 'Guest', 'Imported Record 0764', 'United Kingdom', 'GB', 'LOFT Suite', 9, 'high', 33300, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0765', 'NG', 'Nigeria', '80725a8dc6374ddbcfc20139b19cb60c64d7489fa2863eda0e9bdcc2d0dba84d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:766', @guest_id, 'Guest', 'Imported Record 0765', 'Nigeria', 'NG', 'Superior Double', 7, 'low', 11725, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0766', 'SE', 'Sweden', '9b519389a552fe7ea3842c87e435f18efdc4e6af5c7db059729c6b7280ec3b7f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:767', @guest_id, 'Guest', 'Imported Record 0766', 'Sweden', 'SE', 'Standard Single', 6, 'low', 6138, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0767', 'KR', 'South Korea', 'be342fdd851a75f5e256e923ddff2ff4b929f34a32084e613ff74dfdae6d4487')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:768', @guest_id, 'Guest', 'Imported Record 0767', 'South Korea', 'KR', 'Standard Double', 3, 'high', 5832, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0768', 'DE', 'Germany', '2b052912ddc15bf4778635d6d28d34c0be981ec8e19386cd8f8d3ccd749fa874')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:769', @guest_id, 'Guest', 'Imported Record 0768', 'Germany', 'DE', 'Junior Suite', 5, 'high', 12385, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0769', 'IT', 'Italy', '9b4eb4d4c9272ddac64cb0fabc8a17f47da7642b7a0f5ba09d306430178c73c2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:770', @guest_id, 'Guest', 'Imported Record 0769', 'Italy', 'IT', 'Suite', 10, 'low', 29760, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0770', 'JP', 'Japan', '06adeb3cf165247959c6a8b3bfe902a4a964d0efc9c717b0ce42ed78376c34fe')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:771', @guest_id, 'Guest', 'Imported Record 0770', 'Japan', 'JP', 'Suite', 2, 'high', 6068, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0771', 'RU', 'Russia', '4edd91460d27967e4e7ba6bcca6e971b997970a9ebdae7c7ac36f47806237513')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:772', @guest_id, 'Guest', 'Imported Record 0771', 'Russia', 'RU', 'Suite', 10, 'low', 26130, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0772', 'SE', 'Sweden', 'ef8298d66c790688a917746d482896e066708752eab0249b5320052efe4027fe')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:773', @guest_id, 'Guest', 'Imported Record 0772', 'Sweden', 'SE', 'Superior Double', 2, 'high', 4198, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0773', 'PK', 'Pakistan', '80a4199db91e2a03a6efb9438b998e46a701808f4aa8cf07c3409b39d260295d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:774', @guest_id, 'Guest', 'Imported Record 0773', 'Pakistan', 'PK', 'Suite', 3, 'low', 7917, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0774', 'IT', 'Italy', '0b59ffef300c50f129563b94053499944b72f6f1278e73411d8031f23041c8e1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:775', @guest_id, 'Guest', 'Imported Record 0774', 'Italy', 'IT', 'Standard Single', 10, 'high', 12450, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0775', 'ES', 'Spain', 'b6090ac59329b707bc4bd1021ceff4cdd41e81c810c4a47e64791b5d4f238375')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:776', @guest_id, 'Guest', 'Imported Record 0775', 'Spain', 'ES', 'LOFT Suite', 3, 'high', 11067, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0776', 'RU', 'Russia', '5b40b28e4465082e305eb0d25bf52119a4f906cf601d5d143ca73a7ebd3d2e11')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:777', @guest_id, 'Guest', 'Imported Record 0776', 'Russia', 'RU', 'Spa Executive', 6, 'low', 14898, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0777', 'BR', 'Brazil', 'd89bbdedda9364e2a709e10b725a04a87d6af28865de0e23a7d834ad7448b610')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:778', @guest_id, 'Guest', 'Imported Record 0777', 'Brazil', 'BR', 'Spa Executive', 6, 'mid', 14118, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0778', 'KR', 'South Korea', '1a998e61f971a9cdd4fa4cd5c09de4ca7bc821640d668c6e8258cc4002a4e1ec')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:779', @guest_id, 'Guest', 'Imported Record 0778', 'South Korea', 'KR', 'Junior Suite', 4, 'mid', 9340, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0779', 'DE', 'Germany', 'b23d0889ec9b91cbb673a3c874ab474add7cf3c92ad21c3a1e8e2fdb3fc0ae94')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:780', @guest_id, 'Guest', 'Imported Record 0779', 'Germany', 'DE', 'Standard Double', 4, 'mid', 6384, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0780', 'ES', 'Spain', 'f9243df79fbb4bf2e2a76ec25adec67ef50720b936ebbc973c33ea2f7b20e3ff')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:781', @guest_id, 'Guest', 'Imported Record 0780', 'Spain', 'ES', 'Superior Double', 10, 'low', 15490, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0781', 'NG', 'Nigeria', 'ceefb5c804ee93df0e0cce35004d67dd89c36cc74fbf638fea5c8ebabfe60133')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:782', @guest_id, 'Guest', 'Imported Record 0781', 'Nigeria', 'NG', 'Suite', 2, 'low', 5690, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0782', 'FR', 'France', '672590831d19f04dbc5271d1ef3ba3c7e757b415b3ff5d1e588a05199e0e4500')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:783', @guest_id, 'Guest', 'Imported Record 0782', 'France', 'FR', 'Superior Double', 2, 'low', 3568, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0783', 'RU', 'Russia', 'c836299be25ad9f1fef75c53b185bbf8e44b2fe0a914a4a37ec14a1d4cf1c52c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:784', @guest_id, 'Guest', 'Imported Record 0783', 'Russia', 'RU', 'Suite', 7, 'low', 17717, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0784', 'RU', 'Russia', 'cec964a931859ec0bd0f3b30a50af50497c5649fdc6df6be64a1f9d6d58da206')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:785', @guest_id, 'Guest', 'Imported Record 0784', 'Russia', 'RU', 'Junior Suite', 4, 'high', 9248, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0785', 'IN', 'India', '70844721c3a5ee7854b0e0a4c0ccdb2a8daf7189cc4f05f53b2e147c981751a5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:786', @guest_id, 'Guest', 'Imported Record 0785', 'India', 'IN', 'Superior Double', 10, 'mid', 15820, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0786', 'DE', 'Germany', 'f66d5a8360c0bced0e5bc77b0abafe81a9f712b1dd5d2fd52f9be72fa3f6ede4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:787', @guest_id, 'Guest', 'Imported Record 0786', 'Germany', 'DE', 'Spa Executive', 3, 'mid', 7260, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0787', 'MX', 'Mexico', '12916156936ad75bacc9226eea8f8a5cab4f743b318a9e46f31446069dbeb7ea')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:788', @guest_id, 'Guest', 'Imported Record 0787', 'Mexico', 'MX', 'Standard Double', 6, 'high', 10872, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0788', 'RU', 'Russia', '53b392a6d761ee11fc9bb30bc95169294ea2f72b1862dd12b2aba06096600606')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:789', @guest_id, 'Guest', 'Imported Record 0788', 'Russia', 'RU', 'Junior Suite', 7, 'low', 14616, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0789', 'IT', 'Italy', '723dbc2be7945f3f63ae476266119f99df57872efd92212e33382da7518d8ed9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:790', @guest_id, 'Guest', 'Imported Record 0789', 'Italy', 'IT', 'Junior Suite', 6, 'mid', 12618, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0790', 'IT', 'Italy', 'e34f9bc07a68a22ba622a4e5138725e6af6b1ef042e97d2ec3ace7da71223480')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:791', @guest_id, 'Guest', 'Imported Record 0790', 'Italy', 'IT', 'Standard Single', 4, 'high', 5184, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0791', 'EG', 'Egypt', '9de78dea9b7ead3b4e0277122eb33b33f90a1f43286bdfa6c5f6a5b8bdf54647')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:792', @guest_id, 'Guest', 'Imported Record 0791', 'Egypt', 'EG', 'Suite', 1, 'mid', 2933, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0792', 'ES', 'Spain', '3ce0913191f89e5755f1a5f06a9a4373dc8b6556834f9730c837ed68c6ab66bb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:793', @guest_id, 'Guest', 'Imported Record 0792', 'Spain', 'ES', 'Junior Suite', 4, 'mid', 8880, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0793', 'KR', 'South Korea', '901f0b519c147224de0ff758fc598d897bde8cf6043bd48697681bcbdadb07d8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:794', @guest_id, 'Guest', 'Imported Record 0793', 'South Korea', 'KR', 'Spa Executive', 10, 'high', 25820, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0794', 'FR', 'France', '2a52312d552bf0e35b0133f0794c5d2dad143aed1079a0d589da02f37188c713')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:795', @guest_id, 'Guest', 'Imported Record 0794', 'France', 'FR', 'Grand Lit', 2, 'mid', 3160, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0795', 'CN', 'China', '21f4e4cea476bee5e9096f3ec21aad04e3c6b089f0d0b66ecabcc9306a250870')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:796', @guest_id, 'Guest', 'Imported Record 0795', 'China', 'CN', 'Standard Single', 8, 'low', 9256, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0796', 'GB', 'United Kingdom', '4b71003b7a491a20b709c616d97f73322a5f48895facccc7efe076cb864ee8b7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:797', @guest_id, 'Guest', 'Imported Record 0796', 'United Kingdom', 'GB', 'Standard Single', 10, 'high', 13990, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0797', 'JP', 'Japan', '2d14bda3764d1b600f0358044e43a27825526e013638ebf4ece2f953e5c47b39')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:798', @guest_id, 'Guest', 'Imported Record 0797', 'Japan', 'JP', 'Superior Double', 10, 'low', 17310, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0798', 'SE', 'Sweden', 'cdcb276d12b723787998a9d1f2fc76a8818d53b962c782a5190ea787880903f8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:799', @guest_id, 'Guest', 'Imported Record 0798', 'Sweden', 'SE', 'Suite', 3, 'low', 7704, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0799', 'IT', 'Italy', '65de4e8173c38c8a1c61963e468051e667835adfa38629cf1be88fa175359916')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:800', @guest_id, 'Guest', 'Imported Record 0799', 'Italy', 'IT', 'Spa Executive', 8, 'mid', 19832, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0800', 'BR', 'Brazil', 'bfd9f6897025bbd6fadff71c2607728cb88be81d6fc5a8cf44259a77c7ad913a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:801', @guest_id, 'Guest', 'Imported Record 0800', 'Brazil', 'BR', 'Spa Executive', 5, 'mid', 11875, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0801', 'AU', 'Australia', 'e7372c05ebf215a4ab993a68d7ccd9e86156d45927ad7d2d00b802f4b97ffefa')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:802', @guest_id, 'Guest', 'Imported Record 0801', 'Australia', 'AU', 'Standard Single', 3, 'high', 4449, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0802', 'FR', 'France', '02b80859f99590dc03751e12da51ea2dd8366b8a8463f477512a178f13ebeaa0')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:803', @guest_id, 'Guest', 'Imported Record 0802', 'France', 'FR', 'Spa Executive', 2, 'mid', 5182, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0803', 'IT', 'Italy', 'd9e1de9296247973555d27883d40605448dacd42b88e3c1242c5b3f0f1ff9a9b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:804', @guest_id, 'Guest', 'Imported Record 0803', 'Italy', 'IT', 'Standard Single', 4, 'low', 3648, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0804', 'GB', 'United Kingdom', '4a7876294dcf97196072067355131e9c73797b078ac98c123b5bfa9771ae649e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:805', @guest_id, 'Guest', 'Imported Record 0804', 'United Kingdom', 'GB', 'Junior Suite', 2, 'mid', 4180, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0805', 'VN', 'Vietnam', 'e42d965cfe46e559b8f55b4ee903e0cf5c088df5da7f0e2f8bf74507cda80827')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:806', @guest_id, 'Guest', 'Imported Record 0805', 'Vietnam', 'VN', 'Junior Suite', 3, 'mid', 7116, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0806', 'AU', 'Australia', '87dcd9a1fff6f043dc75441be605f0f998c9c6a504bd5f75a4cc8abdee41d3c8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:807', @guest_id, 'Guest', 'Imported Record 0806', 'Australia', 'AU', 'Spa Executive', 6, 'low', 14580, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0807', 'CN', 'China', '648ba6c8d8ec28fcad684f4047f6e77da45716013b165f915bd2ba845fe9887e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:808', @guest_id, 'Guest', 'Imported Record 0807', 'China', 'CN', 'LOFT Suite', 2, 'high', 7992, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0808', 'CN', 'China', '558ddc724007916e770e6e6ec02cbc9e679da23ef3f8db91f48f0ae78a1be4d4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:809', @guest_id, 'Guest', 'Imported Record 0808', 'China', 'CN', 'Spa Executive', 3, 'low', 6156, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0809', 'IT', 'Italy', 'c65ef5004c88798216025f5886ca7e6ffff437ec09944f58de372b61de4dc627')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:810', @guest_id, 'Guest', 'Imported Record 0809', 'Italy', 'IT', 'Junior Suite', 7, 'mid', 14644, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0810', 'BR', 'Brazil', '0644cbbc19401fbe221d09fb1db171c63b9f83a05428bd76081b2db865c1be35')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:811', @guest_id, 'Guest', 'Imported Record 0810', 'Brazil', 'BR', 'Junior Suite', 3, 'low', 6510, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0811', 'MX', 'Mexico', 'c8ad76aa91fa858ba2093aa2c759720f66efe7c88b9557f57acc40983473b26e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:812', @guest_id, 'Guest', 'Imported Record 0811', 'Mexico', 'MX', 'Grand Lit', 10, 'mid', 14090, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0812', 'AU', 'Australia', '515bb10c3bbf14d500bd87dbadc9dd07e652e529f9cad8d358ab6219d93435eb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:813', @guest_id, 'Guest', 'Imported Record 0812', 'Australia', 'AU', 'Junior Suite', 2, 'high', 4708, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0813', 'JP', 'Japan', '7e623a132ca0c5ee6276f6bf7f8fef660ca82b30aabb631da0e4bdc460ceeabd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:814', @guest_id, 'Guest', 'Imported Record 0813', 'Japan', 'JP', 'Spa Executive', 4, 'mid', 8948, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0814', 'IN', 'India', '1349d58c59e2d6b8e7b591c159bcc2a0ee7ae3f3c46dcad40a0f6eb6f4e9e5ce')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:815', @guest_id, 'Guest', 'Imported Record 0814', 'India', 'IN', 'Superior Double', 5, 'high', 10880, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0815', 'IN', 'India', 'e24ccaf573c6f6878dd5e7ebc4265e1bc831a46d5977ccf59b2601f6de82ae05')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:816', @guest_id, 'Guest', 'Imported Record 0815', 'India', 'IN', 'Standard Double', 6, 'mid', 9084, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0816', 'BR', 'Brazil', 'f8bcc6687dae4cb405b32f31134b1b3fe2abaa295774d4e520619f8a07965ce7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:817', @guest_id, 'Guest', 'Imported Record 0816', 'Brazil', 'BR', 'Junior Suite', 4, 'low', 7824, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0817', 'GB', 'United Kingdom', '98abf73cfecd5866356d837e8326198c95b079e4f5ffe7378c6fa047955d8846')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:818', @guest_id, 'Guest', 'Imported Record 0817', 'United Kingdom', 'GB', 'Suite', 10, 'high', 33550, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0818', 'BR', 'Brazil', 'ca723365f1bb34a78badd36fc84125f8ed51fcb91762f490b23696f2875730c9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:819', @guest_id, 'Guest', 'Imported Record 0818', 'Brazil', 'BR', 'Junior Suite', 2, 'low', 4028, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0819', 'FR', 'France', '9f3b963cecd41ff7f6be1c1f51c33b9d9da53276eaed2d751a22e28af2a0761e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:820', @guest_id, 'Guest', 'Imported Record 0819', 'France', 'FR', 'Suite', 1, 'low', 2860, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0820', 'CN', 'China', '60b3fc519a69ea1f723af99e0c6f3108e52e2175b1219ae0ae5d1717c725b68c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:821', @guest_id, 'Guest', 'Imported Record 0820', 'China', 'CN', 'Grand Lit', 8, 'low', 9064, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0821', 'MX', 'Mexico', '418e0613be1b773544e79905e3a64a409309e9a8ed1bcf8fedd2b1fa910bb9b5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:822', @guest_id, 'Guest', 'Imported Record 0821', 'Mexico', 'MX', 'Standard Double', 4, 'low', 5252, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0822', 'FR', 'France', '1d2b298b7b2576f32e35befbe44b96799aa692f48913c823e31a1b0299bbec1a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:823', @guest_id, 'Guest', 'Imported Record 0822', 'France', 'FR', 'Standard Single', 2, 'mid', 2454, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0823', 'EG', 'Egypt', '1d44af0adf817db40f1e68b7cdc7c1b638abe4f51ba8587f36b1b6a95f7be009')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:824', @guest_id, 'Guest', 'Imported Record 0823', 'Egypt', 'EG', 'Standard Single', 4, 'mid', 5076, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0824', 'NG', 'Nigeria', '8cd35e7d29aac491e873060f591b7e7d445cc01d2a507bd26da5e311113fbe96')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:825', @guest_id, 'Guest', 'Imported Record 0824', 'Nigeria', 'NG', 'Grand Lit', 2, 'high', 3570, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0825', 'BR', 'Brazil', '3c9ee69f00d9b57471e54e34b5fc5bfd9ddc55681f594c2366a1ec1049e0a202')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:826', @guest_id, 'Guest', 'Imported Record 0825', 'Brazil', 'BR', 'Spa Executive', 4, 'mid', 9668, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0826', 'FR', 'France', '95e3ea8526e8e79b8a61d52766c7c9398a4117801d208c30e316fcb44651c653')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:827', @guest_id, 'Guest', 'Imported Record 0826', 'France', 'FR', 'Suite', 2, 'mid', 6586, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0827', 'CN', 'China', 'c0b956c9c3dd058d7d8d840ede5029d352e9e9a86d1b0aa9d585c1306f984cfe')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:828', @guest_id, 'Guest', 'Imported Record 0827', 'China', 'CN', 'LOFT Suite', 6, 'mid', 21186, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0828', 'RU', 'Russia', 'd33cfe1fb435c5ca34817375f981acd228799e3e38691362115330fd721a648b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:829', @guest_id, 'Guest', 'Imported Record 0828', 'Russia', 'RU', 'Suite', 6, 'low', 17136, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0829', 'US', 'United States', '6f2c4e8264f682876b798992be662bfe9917e351095c43fbdde3fb3641a48c62')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:830', @guest_id, 'Guest', 'Imported Record 0829', 'United States', 'US', 'Grand Lit', 1, 'high', 1660, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0830', 'IN', 'India', '71b6d79ad10cae2d95aaa5cdbbbc65982441cef4cb4748fc9e44ad54969c986d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:831', @guest_id, 'Guest', 'Imported Record 0830', 'India', 'IN', 'Superior Double', 9, 'mid', 16461, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0831', 'PK', 'Pakistan', '2d609eb45d923f5f2f7e1d58d46c64c5f233ca66dbf1400b7eb986c145473c62')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:832', @guest_id, 'Guest', 'Imported Record 0831', 'Pakistan', 'PK', 'Standard Single', 7, 'mid', 7707, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0832', 'BR', 'Brazil', 'fa37e2b5179981add08c7b8ac80cc1532eb54abf2f815faee7cb24a46aa21f50')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:833', @guest_id, 'Guest', 'Imported Record 0832', 'Brazil', 'BR', 'Standard Double', 6, 'mid', 9864, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0833', 'PK', 'Pakistan', 'c12e0e469fb15e57648ac57c908d167d257e2bd4554174eefefef36b5cc1c6e3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:834', @guest_id, 'Guest', 'Imported Record 0833', 'Pakistan', 'PK', 'LOFT Suite', 10, 'mid', 34080, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0834', 'GB', 'United Kingdom', 'd43c76262ddb0b0a91e3419062ae8a44f5b645ac5e7762eb5691e587c27f98af')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:835', @guest_id, 'Guest', 'Imported Record 0834', 'United Kingdom', 'GB', 'Suite', 4, 'mid', 12280, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0835', 'US', 'United States', 'fdcf675662c651ae03d16bf79bf6f4f38470409ea5bef657e9215c80c7d246e4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:836', @guest_id, 'Guest', 'Imported Record 0835', 'United States', 'US', 'Grand Lit', 3, 'low', 4143, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0836', 'PK', 'Pakistan', '22c9a01274aacb3fc39334633b1f28af7bf7d55e2e5cf7e200737b701aad1cea')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:837', @guest_id, 'Guest', 'Imported Record 0836', 'Pakistan', 'PK', 'Spa Executive', 1, 'low', 2088, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0837', 'FR', 'France', 'feb8ce1317a421b646fd69ee08a011560d5544a83270d4c66a4a08b3800f26c1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:838', @guest_id, 'Guest', 'Imported Record 0837', 'France', 'FR', 'Superior Double', 6, 'low', 10626, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0838', 'MX', 'Mexico', '3163638ab812263ee53198c8cd8800904f9d08b9d6c76633447fe7925ae77422')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:839', @guest_id, 'Guest', 'Imported Record 0838', 'Mexico', 'MX', 'Grand Lit', 9, 'mid', 13923, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0839', 'IT', 'Italy', 'e1750cacd9f1258a0347229961cadac258e1d531a045672d9ab8a34666279da7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:840', @guest_id, 'Guest', 'Imported Record 0839', 'Italy', 'IT', 'Suite', 7, 'mid', 21378, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0840', 'IT', 'Italy', '3ef159f0e35f1c0b5f17dc2edefd19f52312592297507e9b8484697e948d3482')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:841', @guest_id, 'Guest', 'Imported Record 0840', 'Italy', 'IT', 'LOFT Suite', 10, 'high', 36450, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0841', 'VN', 'Vietnam', 'ffaaf97c18722e986379badc6eb9d00f10c33e2b22f6c05caaeebd6bc8a34767')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:842', @guest_id, 'Guest', 'Imported Record 0841', 'Vietnam', 'VN', 'Superior Double', 9, 'high', 17739, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0842', 'CN', 'China', 'eb9e139c4726a55295262bcfb7501ad1c6f65510c03bb1401e7646ad284c2bd7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:843', @guest_id, 'Guest', 'Imported Record 0842', 'China', 'CN', 'Standard Single', 4, 'mid', 4600, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0843', 'CA', 'Canada', '721ad3737d11550f322f9bccc1aeebee88568d466e74346386d5744a885fe4a5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:844', @guest_id, 'Guest', 'Imported Record 0843', 'Canada', 'CA', 'LOFT Suite', 5, 'high', 19675, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0844', 'BR', 'Brazil', 'b6742b79ded3f8de3c947a51965a6f038dafaeed5db235508439601732990fe7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:845', @guest_id, 'Guest', 'Imported Record 0844', 'Brazil', 'BR', 'Spa Executive', 3, 'mid', 7398, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0845', 'KR', 'South Korea', 'abd963ac669ea37e1279d77afec0ef9f7732afc0c074041339183fa3236f76bb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:846', @guest_id, 'Guest', 'Imported Record 0845', 'South Korea', 'KR', 'LOFT Suite', 2, 'mid', 6684, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0846', 'SE', 'Sweden', '080900746ef8bc2beaf656b9df0b0eb5082c2fd9a3f22a4695214a8b32ec3b54')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:847', @guest_id, 'Guest', 'Imported Record 0846', 'Sweden', 'SE', 'Superior Double', 9, 'low', 13752, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0847', 'RU', 'Russia', '659c894b1f3a83a2276e5710f641a60db15de238dfdbd3e1111637cc4ab02f5e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:848', @guest_id, 'Guest', 'Imported Record 0847', 'Russia', 'RU', 'Spa Executive', 1, 'mid', 2208, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0848', 'IN', 'India', 'a53baf9f2151a1c9beeafccbcb94a8a0ff2f5bedee236c48ef9dccbf2ca78d6e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:849', @guest_id, 'Guest', 'Imported Record 0848', 'India', 'IN', 'Grand Lit', 1, 'high', 1752, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0849', 'DE', 'Germany', '5aae9ba4404b5da1ef353199e82e3634915106aff5807db5d40afd6710a7f73a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:850', @guest_id, 'Guest', 'Imported Record 0849', 'Germany', 'DE', 'Junior Suite', 2, 'mid', 4304, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0850', 'MX', 'Mexico', '84167b41d59afe18cf7a8e237ad2d1d9ec1527263acb65aae97616b7a6dd698a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:851', @guest_id, 'Guest', 'Imported Record 0850', 'Mexico', 'MX', 'Standard Double', 7, 'high', 11795, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0851', 'GB', 'United Kingdom', 'b94a5467a49f91f9e19959a305b4be74f5b7d40c321c0f76e275ba58c1e3f00c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:852', @guest_id, 'Guest', 'Imported Record 0851', 'United Kingdom', 'GB', 'Spa Executive', 7, 'high', 18977, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0852', 'VN', 'Vietnam', 'd61a077f0b21036bda99a1fd53733850f9f750b751e7e30698775b524d42a04d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:853', @guest_id, 'Guest', 'Imported Record 0852', 'Vietnam', 'VN', 'Superior Double', 10, 'high', 18950, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0853', 'FR', 'France', '28f843f6ed2e7dc0e0e7cb18d1b2f1eb5e718f93e56b88079bc1c5b7e499861d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:854', @guest_id, 'Guest', 'Imported Record 0853', 'France', 'FR', 'Superior Double', 6, 'high', 11022, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0854', 'ES', 'Spain', '7c30e1c183ca60e4b5df04087806330f4074a86f2fbed7bfd3aed292db17e21b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:855', @guest_id, 'Guest', 'Imported Record 0854', 'Spain', 'ES', 'LOFT Suite', 3, 'mid', 10668, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0855', 'CA', 'Canada', '5ddef36d3e66ee992241826047fe63169af45786bd9995ce3e1fae15ec760b83')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:856', @guest_id, 'Guest', 'Imported Record 0855', 'Canada', 'CA', 'Suite', 5, 'low', 14450, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0856', 'IN', 'India', 'e1541725ac49f33938703c530e3d4ad1c1d08ba951cba4aad74e95f075e96ebc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:857', @guest_id, 'Guest', 'Imported Record 0856', 'India', 'IN', 'Suite', 5, 'high', 16170, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0857', 'VN', 'Vietnam', '4fe1cc767c4b027e1e632b0dfee2596cf0138604c63792bff19c80de4c5b284b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:858', @guest_id, 'Guest', 'Imported Record 0857', 'Vietnam', 'VN', 'LOFT Suite', 3, 'mid', 10359, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0858', 'RU', 'Russia', 'f5647f26b7733a0368e7b6f185454a5e1afea5d1ae30815d361c71ad82508776')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:859', @guest_id, 'Guest', 'Imported Record 0858', 'Russia', 'RU', 'LOFT Suite', 3, 'mid', 10506, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0859', 'SE', 'Sweden', 'cc51a1906003a58f719faa66eca8ab582676e47d34dcc9737725f968e7bce9fe')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:860', @guest_id, 'Guest', 'Imported Record 0859', 'Sweden', 'SE', 'Standard Double', 3, 'low', 4455, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0860', 'IN', 'India', 'f50ee84b5a17a16233953983b14359d540ce0bbf1c943cfeca7cdc147f7fd165')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:861', @guest_id, 'Guest', 'Imported Record 0860', 'India', 'IN', 'Standard Single', 5, 'mid', 6030, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0861', 'DE', 'Germany', '98b6524f663a3f474aa224b264290d119b34dc028e9d865a69c7287d950f8cb3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:862', @guest_id, 'Guest', 'Imported Record 0861', 'Germany', 'DE', 'Spa Executive', 5, 'mid', 11365, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0862', 'KR', 'South Korea', '1810ff265cee44d4f0b259c2a727192525ffa7c4c93d2a7105ef6ebe66f36ff7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:863', @guest_id, 'Guest', 'Imported Record 0862', 'South Korea', 'KR', 'Spa Executive', 5, 'high', 12805, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0863', 'IN', 'India', '6ec15217b2ce22bfacb3042b4a5fc9b44a4cdd734f3e292ee86f8bf42f7f9ac1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:864', @guest_id, 'Guest', 'Imported Record 0863', 'India', 'IN', 'Superior Double', 7, 'high', 14378, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0864', 'NG', 'Nigeria', '3e00b3efa99441b63eb7d73cbe2fd305b860afb86a05177da7d87bacf5088510')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:865', @guest_id, 'Guest', 'Imported Record 0864', 'Nigeria', 'NG', 'LOFT Suite', 1, 'low', 3245, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0865', 'FR', 'France', 'f9f02f5b9e2755fd58e7439ed81882c404661cf3ecebe9ee9d3fa0b702cee556')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:866', @guest_id, 'Guest', 'Imported Record 0865', 'France', 'FR', 'Spa Executive', 8, 'mid', 20448, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0866', 'MX', 'Mexico', '87e876eb7a92763faf4fbc971fe77055e9240f6e0ef0c9f7b548704db2035573')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:867', @guest_id, 'Guest', 'Imported Record 0866', 'Mexico', 'MX', 'Standard Double', 4, 'high', 7892, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0867', 'VN', 'Vietnam', '58671c240c677591e8dae25cf0855b291e2fe5b85b2b9fbc9c70b32845f28f64')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:868', @guest_id, 'Guest', 'Imported Record 0867', 'Vietnam', 'VN', 'Junior Suite', 4, 'high', 9708, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0868', 'MX', 'Mexico', 'cd687cc5123bbd0649867d6b5e75a3c3016d4a859fadfcf60b4145c7f0d58bb1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:869', @guest_id, 'Guest', 'Imported Record 0868', 'Mexico', 'MX', 'LOFT Suite', 10, 'mid', 34480, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0869', 'VN', 'Vietnam', 'e377825c1e996f6bf16d1d0fcc51c1d7ceda429d946adf00768fc0d036cda96b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:870', @guest_id, 'Guest', 'Imported Record 0869', 'Vietnam', 'VN', 'Standard Double', 10, 'low', 13450, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0870', 'EG', 'Egypt', '8c5aa46ed28ccdd0694553411d8e70671348699ef369084aa91ef540be7d7979')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:871', @guest_id, 'Guest', 'Imported Record 0870', 'Egypt', 'EG', 'Standard Single', 1, 'high', 1498, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0871', 'NG', 'Nigeria', '55e3d2e2e519cb71b8fd4b4557b292b4bd1404be45be42c43f74b982d8e0fcfc')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:872', @guest_id, 'Guest', 'Imported Record 0871', 'Nigeria', 'NG', 'Suite', 6, 'high', 19554, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0872', 'DE', 'Germany', 'eae5a39d62caf3eb6d27518b31bb05782568d36967f7127ea220dac778e818bb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:873', @guest_id, 'Guest', 'Imported Record 0872', 'Germany', 'DE', 'Grand Lit', 5, 'mid', 7760, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0873', 'IN', 'India', 'f39c6d80f47073c46c7da19f432fe628e1137dac6ad195c0c4f8744fcf309aef')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:874', @guest_id, 'Guest', 'Imported Record 0873', 'India', 'IN', 'Junior Suite', 10, 'mid', 23600, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0874', 'AU', 'Australia', '3c89b2cad8a9492a60251e2665291cdf7f30e4c0581552d484d1f7c7ee7f3503')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:875', @guest_id, 'Guest', 'Imported Record 0874', 'Australia', 'AU', 'Spa Executive', 1, 'low', 2102, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0875', 'CN', 'China', '215fd0f2939a62313a3d1e85bb7d1a71cfcb876b14c8cb9d4020fa607b7b3374')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:876', @guest_id, 'Guest', 'Imported Record 0875', 'China', 'CN', 'Superior Double', 8, 'high', 15440, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0876', 'ES', 'Spain', '48b172d8a0ba696e832d944105588358ddc9ec616c4baf8b2b6e5ad096ecb5f1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:877', @guest_id, 'Guest', 'Imported Record 0876', 'Spain', 'ES', 'Junior Suite', 9, 'high', 20943, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0877', 'RU', 'Russia', 'f0785b5397d7084c681678502609d7a69080ed17e5e3531ff14016178204c669')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:878', @guest_id, 'Guest', 'Imported Record 0877', 'Russia', 'RU', 'Superior Double', 7, 'high', 12740, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0878', 'BR', 'Brazil', '4fb4551a84c054eb2836fd6bc06f6d1e49682b3c9dcc323de8b68f7f6a2f61d1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:879', @guest_id, 'Guest', 'Imported Record 0878', 'Brazil', 'BR', 'Suite', 10, 'high', 34110, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0879', 'MX', 'Mexico', '8649342c230ef3ad134b8b6460222e6501d6e15bf9e638b568e34e6bfdad3d68')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:880', @guest_id, 'Guest', 'Imported Record 0879', 'Mexico', 'MX', 'Junior Suite', 5, 'high', 11220, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0880', 'GB', 'United Kingdom', 'd5cb6fe46697eb5da25dc299d0f099464c12e84b81cbdcebe26ff0daba06a60b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:881', @guest_id, 'Guest', 'Imported Record 0880', 'United Kingdom', 'GB', 'Junior Suite', 9, 'mid', 19548, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0881', 'BR', 'Brazil', '81a3a23990c332dafa115085922a3d67430909221a99863d1df363741c5a0ae9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:882', @guest_id, 'Guest', 'Imported Record 0881', 'Brazil', 'BR', 'Junior Suite', 8, 'low', 17016, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0882', 'BR', 'Brazil', 'b79902feba99da4d2ed769c07e426de285e45a20b924d54d1f348d7b213ef17a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:883', @guest_id, 'Guest', 'Imported Record 0882', 'Brazil', 'BR', 'Superior Double', 5, 'high', 10945, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0883', 'US', 'United States', 'bdafaf058a09b8877557521df5b59726824c162903e32fdbdd83d1dffd09eb35')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:884', @guest_id, 'Guest', 'Imported Record 0883', 'United States', 'US', 'Grand Lit', 6, 'low', 7284, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0884', 'AU', 'Australia', '50cdc573df0bf859e66ea424958b5f449de17576c34191cf4732e6920a061fb9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:885', @guest_id, 'Guest', 'Imported Record 0884', 'Australia', 'AU', 'Superior Double', 8, 'mid', 13608, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0885', 'JP', 'Japan', 'a763ae7eb53806e66eea789abcd5ce6e4c54b1fab109e5dcb10fb43c70aeb77a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:886', @guest_id, 'Guest', 'Imported Record 0885', 'Japan', 'JP', 'Suite', 9, 'high', 30411, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0886', 'KR', 'South Korea', 'eba1983add5a3b27337f564c003198c41c6a36b0d12f4439f20643566cc8da6d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:887', @guest_id, 'Guest', 'Imported Record 0886', 'South Korea', 'KR', 'Standard Single', 6, 'high', 8448, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0887', 'KR', 'South Korea', 'fa76551525209d9785aa71bd21de57355088f214f79b33d128a6b6f0c0e71f4c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:888', @guest_id, 'Guest', 'Imported Record 0887', 'South Korea', 'KR', 'Superior Double', 4, 'high', 7308, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0888', 'VN', 'Vietnam', '619bc7fae8eac67d5e09d979d965fe66270352cc1e1c8c3e86c85cea8d6ef158')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:889', @guest_id, 'Guest', 'Imported Record 0888', 'Vietnam', 'VN', 'Spa Executive', 6, 'mid', 15096, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0889', 'GB', 'United Kingdom', 'a7bfc59dcfa95b2f420f8fe954aec2c9ad255c2db2cd4c2729598827d90d5316')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:890', @guest_id, 'Guest', 'Imported Record 0889', 'United Kingdom', 'GB', 'Standard Single', 7, 'high', 9898, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0890', 'ES', 'Spain', '094cbce3fe004bf06f0faeb6b1cc12d5a452915f3d64f4412ce02970ce5b6eea')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:891', @guest_id, 'Guest', 'Imported Record 0890', 'Spain', 'ES', 'Spa Executive', 3, 'low', 6546, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0891', 'CN', 'China', '4e9075831f187e4d50cc6a0f9e7bf973bf8fdae9909985067596556fcee38db9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:892', @guest_id, 'Guest', 'Imported Record 0891', 'China', 'CN', 'Standard Single', 1, 'high', 1218, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0892', 'RU', 'Russia', 'e8444825a75ab6fe0c2b6f8628154cd35acbd63b70959a9122d0ab51dc889bc3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:893', @guest_id, 'Guest', 'Imported Record 0892', 'Russia', 'RU', 'Grand Lit', 7, 'mid', 9359, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0893', 'IT', 'Italy', '8cea5428a695f03574eff52b6a7aba0e94a7baff7a117191b3b10398a6d5893b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:894', @guest_id, 'Guest', 'Imported Record 0893', 'Italy', 'IT', 'Standard Double', 8, 'mid', 10504, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0894', 'IN', 'India', '050089e34602afbe26c0ce45a6913f3e06d90e1e1afecf97c9abd34c2a93d1ac')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:895', @guest_id, 'Guest', 'Imported Record 0894', 'India', 'IN', 'Standard Double', 10, 'low', 14050, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0895', 'DE', 'Germany', '7949680d6dc16789d90f2b29ef19371e27910fad1eea6d3cea52858104756668')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:896', @guest_id, 'Guest', 'Imported Record 0895', 'Germany', 'DE', 'Junior Suite', 1, 'mid', 2210, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0896', 'RU', 'Russia', 'cd0cf4bd4bef0c2005c5b0327619093fd7d778a2c8c27453333bc7f599d6c623')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:897', @guest_id, 'Guest', 'Imported Record 0896', 'Russia', 'RU', 'Standard Single', 3, 'mid', 3252, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0897', 'DE', 'Germany', '257892b48e6dd136a39869e58f8112cc7096293156d16f1b463befa5f284f2ba')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:898', @guest_id, 'Guest', 'Imported Record 0897', 'Germany', 'DE', 'Spa Executive', 3, 'mid', 7482, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0898', 'PK', 'Pakistan', 'ff280442d3183c7a56a6f3889b2e24321e98edaa47df90871ebc59582a58c206')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:899', @guest_id, 'Guest', 'Imported Record 0898', 'Pakistan', 'PK', 'Junior Suite', 6, 'high', 14508, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0899', 'KR', 'South Korea', '2889388adbd34c178807bf17a22cc5b8f3aeabe1e4df802f4a886c7fedaf8a8b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:900', @guest_id, 'Guest', 'Imported Record 0899', 'South Korea', 'KR', 'Superior Double', 6, 'high', 11892, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0900', 'CA', 'Canada', '7adfa575dec210f88fd43f57ebb9c0310f573d45fa3a965ba4b2efba5198dc0c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:901', @guest_id, 'Guest', 'Imported Record 0900', 'Canada', 'CA', 'Spa Executive', 9, 'high', 24867, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0901', 'PK', 'Pakistan', '2f63bdc2624b7483c4ec478d5b5bb048550a4128c18ff23c980f7128db2e9b8d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:902', @guest_id, 'Guest', 'Imported Record 0901', 'Pakistan', 'PK', 'Junior Suite', 6, 'low', 10986, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0902', 'PK', 'Pakistan', 'a0657381943fef0bee65d7b50de4384c1234a8d2db9293ce26573bb0f6f8fe8d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:903', @guest_id, 'Guest', 'Imported Record 0902', 'Pakistan', 'PK', 'Spa Executive', 1, 'low', 2109, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0903', 'GB', 'United Kingdom', '1e6fd44496295c3c08ab51f85e201a903f707bd0e067c0b4d32495c9abda9b80')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:904', @guest_id, 'Guest', 'Imported Record 0903', 'United Kingdom', 'GB', 'Standard Double', 6, 'low', 8814, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0904', 'FR', 'France', 'fae4ad4a78fec0c2b55d91486b6394063d909ea98d8b9f2e8b519a0c79178de5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:905', @guest_id, 'Guest', 'Imported Record 0904', 'France', 'FR', 'Suite', 3, 'high', 9456, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0905', 'AU', 'Australia', '8577aa34d772b1385b536548b4ff107a65592c4917199cbb0baf7390303efcb1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:906', @guest_id, 'Guest', 'Imported Record 0905', 'Australia', 'AU', 'Suite', 1, 'high', 3324, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0906', 'FR', 'France', 'c8f74188550c2c46516c784cdef88db438b8aaf20e5f895a1894ec3e9a8ff271')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:907', @guest_id, 'Guest', 'Imported Record 0906', 'France', 'FR', 'LOFT Suite', 3, 'mid', 10404, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0907', 'MX', 'Mexico', '551675d671a3f7fe0e06336659dd5c55b844e6c2b98110daed17dee9e2afc1b1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:908', @guest_id, 'Guest', 'Imported Record 0907', 'Mexico', 'MX', 'Grand Lit', 6, 'high', 9216, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0908', 'IN', 'India', 'daf22f3db4d07549bd8527fc32bcd9759ea81474258b196d7c903ae8ef5edc61')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:909', @guest_id, 'Guest', 'Imported Record 0908', 'India', 'IN', 'Suite', 2, 'high', 6922, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0909', 'ES', 'Spain', '06a70c74c5b38a2cd7bbd1a28b224aa7381c6b88b59aadf98bf599178c44afe6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:910', @guest_id, 'Guest', 'Imported Record 0909', 'Spain', 'ES', 'Suite', 4, 'high', 12696, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0910', 'BR', 'Brazil', '071f561086ec6fe82a071da0c0cf9508f8a53f8c62d00703b452009088e0dd48')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:911', @guest_id, 'Guest', 'Imported Record 0910', 'Brazil', 'BR', 'Standard Double', 1, 'low', 1479, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0911', 'CA', 'Canada', '6cb4f54bbd8c4f824fa062710a609961fed2ee63866475bd8231ca5eaacf435f')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:912', @guest_id, 'Guest', 'Imported Record 0911', 'Canada', 'CA', 'Suite', 3, 'high', 9210, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0912', 'NG', 'Nigeria', '2668d350bcb2790d3e3dca4362a701e52278cbfb2e831c01ce6e7b572e41bd4c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:913', @guest_id, 'Guest', 'Imported Record 0912', 'Nigeria', 'NG', 'Grand Lit', 4, 'low', 5244, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0913', 'FR', 'France', 'e956de2d0df9608f5541c0381aa4d39aefd433abd3b3595cb964be66a5953cdb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:914', @guest_id, 'Guest', 'Imported Record 0913', 'France', 'FR', 'Suite', 4, 'low', 11428, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0914', 'GB', 'United Kingdom', '6f8616ae64c76a4679e3c1e9ddeb84765f1af85f8ae9e2803e3041aa413cb440')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:915', @guest_id, 'Guest', 'Imported Record 0914', 'United Kingdom', 'GB', 'Junior Suite', 1, 'high', 2220, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0915', 'SE', 'Sweden', '74d3b1e290c19e950858a4e369af67ccb87693c31aaf2d4ae80be8dfa36e6b18')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:916', @guest_id, 'Guest', 'Imported Record 0915', 'Sweden', 'SE', 'Superior Double', 2, 'low', 3484, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0916', 'SE', 'Sweden', '21d1474e355d97d53a37e395939bcd7bd09186eafdbef81c03946e18a9aceab4')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:917', @guest_id, 'Guest', 'Imported Record 0916', 'Sweden', 'SE', 'Grand Lit', 10, 'high', 14520, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0917', 'RU', 'Russia', 'f893f04842d1a9ae589f0a349f8b728a9a4cde760e8515ecd9cc2a984693ae8d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:918', @guest_id, 'Guest', 'Imported Record 0917', 'Russia', 'RU', 'Spa Executive', 7, 'low', 16128, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0918', 'KR', 'South Korea', '8fd1f1665c038ce21e66d8fac305f8aa08925393a076f7d810a5e4c5a71d132a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:919', @guest_id, 'Guest', 'Imported Record 0918', 'South Korea', 'KR', 'Spa Executive', 4, 'low', 8768, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0919', 'US', 'United States', '607a5bdae1292c783915e58ac7db8b1054b534d1a41c62712ef7664703e8f696')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:920', @guest_id, 'Guest', 'Imported Record 0919', 'United States', 'US', 'Suite', 5, 'high', 16015, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0920', 'SE', 'Sweden', '6e9fbe9c30d201c99d0344e00022e780cbe0a98dc37e26a09f057eeeba20bb2c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:921', @guest_id, 'Guest', 'Imported Record 0920', 'Sweden', 'SE', 'Junior Suite', 10, 'mid', 21350, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0921', 'SE', 'Sweden', '19f25190340c98ab3a1257f6f8ebfff86bee40e12f7a1fc811007e915544e176')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:922', @guest_id, 'Guest', 'Imported Record 0921', 'Sweden', 'SE', 'Grand Lit', 7, 'high', 10535, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0922', 'CN', 'China', 'ddaae6ea8a173dd6e9fc3926b111c291291967b157cdcf16da1b62b1144df2c3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:923', @guest_id, 'Guest', 'Imported Record 0922', 'China', 'CN', 'Spa Executive', 9, 'high', 23553, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0923', 'ES', 'Spain', 'f163df8a986776f00124f9da4b872f2fa0104c0fb97f60df1145984aeb53444d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:924', @guest_id, 'Guest', 'Imported Record 0923', 'Spain', 'ES', 'Grand Lit', 1, 'mid', 1210, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0924', 'IT', 'Italy', '49ef1f5bc9c1795a233c5563815df364684d68ec6a3dbce197396e9302c2cdfd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:925', @guest_id, 'Guest', 'Imported Record 0924', 'Italy', 'IT', 'Grand Lit', 7, 'mid', 9408, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0925', 'GB', 'United Kingdom', 'a59cd391f9c2cd6d6ef6523412ed7b6831d715a3f86f128833688e108dab428b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:926', @guest_id, 'Guest', 'Imported Record 0925', 'United Kingdom', 'GB', 'Junior Suite', 3, 'high', 6816, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0926', 'JP', 'Japan', '578a406d28fa3dcc798c982a90de79ae9355e13965db4a145c6606cde96e84c6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:927', @guest_id, 'Guest', 'Imported Record 0926', 'Japan', 'JP', 'Spa Executive', 8, 'mid', 19192, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0927', 'CA', 'Canada', '65ea998e231228517eb3aa00916757918f5e4c64f36832ac4d95bfdeb9e65913')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:928', @guest_id, 'Guest', 'Imported Record 0927', 'Canada', 'CA', 'Grand Lit', 6, 'mid', 9576, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0928', 'AU', 'Australia', '521e528b2b1308115c01732d7f77534aaa4a45b235e8eb808fae59a8cb11b477')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:929', @guest_id, 'Guest', 'Imported Record 0928', 'Australia', 'AU', 'Spa Executive', 6, 'high', 15582, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0929', 'ES', 'Spain', 'f2abd07407acf95e968d195222aaf916ab2d5a7439c8413d95d9d61219fd27d7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:930', @guest_id, 'Guest', 'Imported Record 0929', 'Spain', 'ES', 'Superior Double', 4, 'low', 6912, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0930', 'RU', 'Russia', '00b81d72623a5b870dc38cb136be033f93318a4da4c7922d2b58d71aba2ee938')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:931', @guest_id, 'Guest', 'Imported Record 0930', 'Russia', 'RU', 'Standard Single', 1, 'high', 1311, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0931', 'ES', 'Spain', '5a3fa81e1fe5a8f86bae9d97e753ff618e6ada9392f65e59cbfa9ec77819b00e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:932', @guest_id, 'Guest', 'Imported Record 0931', 'Spain', 'ES', 'Suite', 4, 'mid', 13176, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0932', 'JP', 'Japan', '48157607c484d6f8b17c1202bfc526ae0d3d039ce8a4fa4437ea010b8ec9c979')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:933', @guest_id, 'Guest', 'Imported Record 0932', 'Japan', 'JP', 'Spa Executive', 1, 'low', 2095, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0933', 'CN', 'China', 'c2f02069d9559cab50dd22bd427afb32469f120f75f4869d6e1d792c8d1a8e04')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:934', @guest_id, 'Guest', 'Imported Record 0933', 'China', 'CN', 'Junior Suite', 3, 'low', 5733, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0934', 'CN', 'China', 'd4af4db08705706f3c943e2a2ab3ccba38f58ebd0d56d3bcfae2b48cd07a0319')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:935', @guest_id, 'Guest', 'Imported Record 0934', 'China', 'CN', 'Spa Executive', 10, 'high', 25490, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0935', 'EG', 'Egypt', '2a1b80f985c9c466942d1fea5d9697596ed8c7e9838a811e45cd6d088b47611d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:936', @guest_id, 'Guest', 'Imported Record 0935', 'Egypt', 'EG', 'Spa Executive', 10, 'mid', 22210, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0936', 'RU', 'Russia', '6ab3c7f82d7ea0b7b5b6da8a259bef1ecf3889a3aede63981ba61438138279f2')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:937', @guest_id, 'Guest', 'Imported Record 0936', 'Russia', 'RU', 'Standard Double', 7, 'low', 10549, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0937', 'BR', 'Brazil', 'cc397211b579b691b97388b1bd1acb94a0bb1a8a81bc514a0e502c18b3175555')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:938', @guest_id, 'Guest', 'Imported Record 0937', 'Brazil', 'BR', 'Superior Double', 9, 'mid', 16632, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0938', 'GB', 'United Kingdom', '438f4b5c40459458de18fa9ee92c29b9c247c2c60ac12c2809460e2ec3cfeae3')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:939', @guest_id, 'Guest', 'Imported Record 0938', 'United Kingdom', 'GB', 'Grand Lit', 3, 'high', 4938, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0939', 'JP', 'Japan', '257c68e09d421145f0dbfaaadb878840045046b37b9a96f8879701d552b6a4dd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:940', @guest_id, 'Guest', 'Imported Record 0939', 'Japan', 'JP', 'LOFT Suite', 7, 'low', 22155, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0940', 'IT', 'Italy', 'a02789741dc25afc0359b1233bc180c3d262fd9160650ac057e589ec268bef6d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:941', @guest_id, 'Guest', 'Imported Record 0940', 'Italy', 'IT', 'Junior Suite', 1, 'mid', 2002, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0941', 'DE', 'Germany', 'b9e0f83db4d40d6df9527bdafd9239b97119b460966a2dc324cc8b43c00a009d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:942', @guest_id, 'Guest', 'Imported Record 0941', 'Germany', 'DE', 'Standard Double', 9, 'low', 13158, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0942', 'MX', 'Mexico', '6e48f7283ebf8ee4bbfa9e260eec3a94c36371099941740c363d5e6da60c4098')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:943', @guest_id, 'Guest', 'Imported Record 0942', 'Mexico', 'MX', 'Spa Executive', 1, 'high', 2588, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0943', 'ES', 'Spain', 'dd40844cecce85b822233cad1dc8585d16111e9ffb17dc5124b58bab56614319')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:944', @guest_id, 'Guest', 'Imported Record 0943', 'Spain', 'ES', 'LOFT Suite', 2, 'low', 6102, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0944', 'PK', 'Pakistan', '5af36634eb9a7334d2fd0c8e3392b8e635485077d4d58299c0dca0887fbdcb52')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:945', @guest_id, 'Guest', 'Imported Record 0944', 'Pakistan', 'PK', 'Superior Double', 9, 'high', 16929, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0945', 'GB', 'United Kingdom', '2db8b7dd1237388f07c462a7a20d29ceb1d71387e0bb7d85f98b56448debc02d')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:946', @guest_id, 'Guest', 'Imported Record 0945', 'United Kingdom', 'GB', 'Suite', 6, 'mid', 18684, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0946', 'IT', 'Italy', '13e8fc7708d61d7d0833d2dffd5628bfe1c34097cdfbc974d6c116dc9ae0c536')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:947', @guest_id, 'Guest', 'Imported Record 0946', 'Italy', 'IT', 'Standard Single', 3, 'high', 4365, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0947', 'AU', 'Australia', 'aaee06272813666035144eecfcb42b41a5519174dd8332fca583e0a83e9e66e9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:948', @guest_id, 'Guest', 'Imported Record 0947', 'Australia', 'AU', 'Spa Executive', 1, 'mid', 2467, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0948', 'PK', 'Pakistan', '97a187ef20b1314178655260e3e3288780b7803fbf3d2777d2a9d66519ab2740')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:949', @guest_id, 'Guest', 'Imported Record 0948', 'Pakistan', 'PK', 'Suite', 7, 'mid', 22449, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0949', 'PK', 'Pakistan', '6741eb32fab7d9a68b67b5a882eb1eeef040b32403bc4a3cefa5b05363c99a30')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:950', @guest_id, 'Guest', 'Imported Record 0949', 'Pakistan', 'PK', 'Standard Single', 5, 'high', 6730, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0950', 'CA', 'Canada', '19ac4eb3ae350c5d2da1aa8a5f7d63bd2d620e835f67e97ec6ae896d584a54be')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:951', @guest_id, 'Guest', 'Imported Record 0950', 'Canada', 'CA', 'Junior Suite', 1, 'mid', 2150, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0951', 'BR', 'Brazil', '48b31aa695245dad9b2c40f3931fffd3f096b74db3deb1fd7e5305815a71edf7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:952', @guest_id, 'Guest', 'Imported Record 0951', 'Brazil', 'BR', 'Standard Single', 1, 'mid', 1181, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0952', 'PK', 'Pakistan', 'c5ddb33cd07d08ce25df30f423b653b19fbef6dffb8237bf2d95d91ca0f7fd6a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:953', @guest_id, 'Guest', 'Imported Record 0952', 'Pakistan', 'PK', 'Junior Suite', 1, 'mid', 2262, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0953', 'BR', 'Brazil', '89ca584aa275732eac9d94949e52bae110ad7ac8d31b7a9bfefdf8aeb0cfc151')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:954', @guest_id, 'Guest', 'Imported Record 0953', 'Brazil', 'BR', 'Superior Double', 9, 'mid', 14769, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0954', 'JP', 'Japan', 'f0cb82af5c80c998c71c9225242b4263978aed65f6ddc8adc4a9909b738692e6')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:955', @guest_id, 'Guest', 'Imported Record 0954', 'Japan', 'JP', 'Grand Lit', 1, 'low', 1265, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0955', 'JP', 'Japan', '8f8314ed9db031bde086070b00f5aab83cd93cfd2718a7b96881d764dff2668e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:956', @guest_id, 'Guest', 'Imported Record 0955', 'Japan', 'JP', 'LOFT Suite', 10, 'low', 34740, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0956', 'CN', 'China', 'ffd76d6515fc83a4b98d03ea93fda6bc3137954f1a870a0813fe6374042f8d5e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:957', @guest_id, 'Guest', 'Imported Record 0956', 'China', 'CN', 'Suite', 7, 'mid', 22561, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0957', 'DE', 'Germany', 'fb103b7fab8a611b9d7d62fbb5b638246867dbcc77dd006650ae3deed62c7db5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:958', @guest_id, 'Guest', 'Imported Record 0957', 'Germany', 'DE', 'Suite', 10, 'low', 27230, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0958', 'US', 'United States', '068f2c5ddd8d464eaf312b4963864da06fee69ab8a05ef32ad38bcfe0a7b340c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:959', @guest_id, 'Guest', 'Imported Record 0958', 'United States', 'US', 'Junior Suite', 4, 'low', 7952, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0959', 'KR', 'South Korea', 'ea3df95a7af6a21609f99a32c1f57da2958af0769516304ec0f010de1860414c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:960', @guest_id, 'Guest', 'Imported Record 0959', 'South Korea', 'KR', 'Superior Double', 5, 'high', 10005, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0960', 'BR', 'Brazil', '2d942b999780c05c3462eba0ef7f10c0fb8c6f983a6cf82366a05ff5fb49394e')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:961', @guest_id, 'Guest', 'Imported Record 0960', 'Brazil', 'BR', 'Standard Double', 10, 'high', 17330, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0961', 'CA', 'Canada', 'de3e3b584fa61734faf2ed6fe0d92111acfeaa03140f538d9921a93672ea3b72')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:962', @guest_id, 'Guest', 'Imported Record 0961', 'Canada', 'CA', 'Spa Executive', 7, 'high', 18753, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0962', 'CN', 'China', '9384c27f792b03df9fd9dab540e57106a601c18c6241be7abc84a82f36c28b25')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:963', @guest_id, 'Guest', 'Imported Record 0962', 'China', 'CN', 'Suite', 1, 'high', 3195, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0963', 'KR', 'South Korea', 'decfcff7e9137a3c9e274dc18ce2eb1a96b077a8301bbf9525fada6b1f290ab9')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:964', @guest_id, 'Guest', 'Imported Record 0963', 'South Korea', 'KR', 'LOFT Suite', 9, 'mid', 30096, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0964', 'EG', 'Egypt', '7bc806be39a62dcff7f890039b13cf1fa9454f8aea23bc81948f079c168a3116')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:965', @guest_id, 'Guest', 'Imported Record 0964', 'Egypt', 'EG', 'Junior Suite', 10, 'mid', 20270, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0965', 'MX', 'Mexico', '2a8f307d868ea32b27bdd2ffe09cb044cb796cd5091351d30a35724177f9331c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:966', @guest_id, 'Guest', 'Imported Record 0965', 'Mexico', 'MX', 'LOFT Suite', 2, 'mid', 7008, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0966', 'RU', 'Russia', '92e243ff0e8d785290d9dd5efcee808cd3d2a48950d762fa45505d6034bf8499')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:967', @guest_id, 'Guest', 'Imported Record 0966', 'Russia', 'RU', 'Superior Double', 1, 'high', 1912, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0967', 'KR', 'South Korea', '430881ca946b9aaf0be8c99fab2d09595ed52d1aac4d833bb0c119a324557398')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:968', @guest_id, 'Guest', 'Imported Record 0967', 'South Korea', 'KR', 'Standard Double', 4, 'low', 5040, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0968', 'AU', 'Australia', 'f6aaa2616bdd2598032269fa6c1dcbd50ab6eaefa81d3abb5d9b13d534011906')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:969', @guest_id, 'Guest', 'Imported Record 0968', 'Australia', 'AU', 'Junior Suite', 3, 'low', 6228, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0969', 'DE', 'Germany', '7b8dfa2c563e73ad271da93f4802175f7abee21a1b5736165162a19e0af21980')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:970', @guest_id, 'Guest', 'Imported Record 0969', 'Germany', 'DE', 'Grand Lit', 10, 'mid', 15030, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0970', 'AU', 'Australia', '283d701010b02b1ee036f246751cfee8a3adf67ff32a7c3a189bc328e3f5e7e7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:971', @guest_id, 'Guest', 'Imported Record 0970', 'Australia', 'AU', 'Spa Executive', 6, 'mid', 14706, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0971', 'KR', 'South Korea', '9cfaeb6278fad12f0ca3db657c4e020b35288d2166d0a738f8dfa7026d966df1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:972', @guest_id, 'Guest', 'Imported Record 0971', 'South Korea', 'KR', 'Spa Executive', 5, 'high', 12985, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0972', 'AU', 'Australia', '67bf5b763646e97fc650a1333074a34427b6b00acac69ef3469b70374ac3f809')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:973', @guest_id, 'Guest', 'Imported Record 0972', 'Australia', 'AU', 'Spa Executive', 8, 'low', 16392, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0973', 'JP', 'Japan', '8e16bca8cf7b39eb0f77dc676da34bc55d24428cc90746f15f278e75ce239b07')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:974', @guest_id, 'Guest', 'Imported Record 0973', 'Japan', 'JP', 'Grand Lit', 4, 'high', 6320, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0974', 'FR', 'France', '57f418a77e9c3355ab607c7b869ab2007bd062d06607153ad3c04dac4b174777')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:975', @guest_id, 'Guest', 'Imported Record 0974', 'France', 'FR', 'LOFT Suite', 4, 'high', 14084, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0975', 'RU', 'Russia', '8b09ee848f0a572e13e6b4883ace7e2c7fb1e714c084a9de401595ad657420f8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:976', @guest_id, 'Guest', 'Imported Record 0975', 'Russia', 'RU', 'Spa Executive', 1, 'low', 2391, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0976', 'NG', 'Nigeria', 'd412b9b6bb287cf90266697b4475bc8a396045fb288d3e97fe307a5e74225ef8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:977', @guest_id, 'Guest', 'Imported Record 0976', 'Nigeria', 'NG', 'Standard Double', 6, 'high', 11532, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0977', 'JP', 'Japan', '4fdffd194a01dc2ec66f3cfd1509b2b5280236142782d439532e2e39f21782dd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:978', @guest_id, 'Guest', 'Imported Record 0977', 'Japan', 'JP', 'Spa Executive', 3, 'mid', 6819, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0978', 'KR', 'South Korea', '7089a2c35b8036c63b9629bf529c7a99973dff56a7a94815fe4854595c2fe834')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:979', @guest_id, 'Guest', 'Imported Record 0978', 'South Korea', 'KR', 'Spa Executive', 1, 'mid', 2218, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0979', 'PK', 'Pakistan', '8639e79feac8a89bdf6da5cbbb1148526a8ffa1d52bd95ebfbd936dcf5f5af22')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:980', @guest_id, 'Guest', 'Imported Record 0979', 'Pakistan', 'PK', 'LOFT Suite', 2, 'mid', 7340, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0980', 'VN', 'Vietnam', '4d2ff3668fd93c658c3c8f61eb5ea90d4089d037aac004ade8cb1895aabe3711')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:981', @guest_id, 'Guest', 'Imported Record 0980', 'Vietnam', 'VN', 'Spa Executive', 3, 'mid', 6924, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0981', 'BR', 'Brazil', '12159733cff2858ad85964f602ddd8d565a9a2ddadcf23cfaf2e83f4f74e1cbb')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:982', @guest_id, 'Guest', 'Imported Record 0981', 'Brazil', 'BR', 'Superior Double', 5, 'high', 10285, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0982', 'KR', 'South Korea', 'ea5051351583b244988db62bf2cf3a7af30af65bf1e87872cbb45a39c88fbb43')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:983', @guest_id, 'Guest', 'Imported Record 0982', 'South Korea', 'KR', 'Superior Double', 9, 'low', 15444, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0983', 'NG', 'Nigeria', '5f78bcfe736234d97c1c4f70c7f9e92ed239bf1b33cba16abf33ac35a2035bea')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:984', @guest_id, 'Guest', 'Imported Record 0983', 'Nigeria', 'NG', 'Standard Single', 4, 'high', 5792, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0984', 'FR', 'France', '06dae0674932c773993515495fe2962016bf28fbf67ca9a96d7c94be6df78e91')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:985', @guest_id, 'Guest', 'Imported Record 0984', 'France', 'FR', 'LOFT Suite', 4, 'high', 15144, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0985', 'CN', 'China', '4dc87104b97efcba399db1e6af9665c22d55d3f37c7bb7d09e0813a961b29d1a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:986', @guest_id, 'Guest', 'Imported Record 0985', 'China', 'CN', 'Junior Suite', 9, 'low', 17163, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0986', 'IN', 'India', '48c6c4769869ec992631c4a66ce6aaad64ab55407b943a9fe9c59caadb80093c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:987', @guest_id, 'Guest', 'Imported Record 0986', 'India', 'IN', 'Standard Double', 1, 'high', 1795, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0987', 'GB', 'United Kingdom', '7f577cd080e0e45de4a42d5a006133e7209ed4e2a9857d752daca43fb93d7bbd')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:988', @guest_id, 'Guest', 'Imported Record 0987', 'United Kingdom', 'GB', 'Suite', 3, 'high', 9984, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0988', 'NG', 'Nigeria', '57fc0ca9545bdbe25a6b26db0536e33f0fbaa6ccd3385fd907afe852fc168873')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:989', @guest_id, 'Guest', 'Imported Record 0988', 'Nigeria', 'NG', 'Standard Double', 1, 'low', 1308, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0989', 'AU', 'Australia', 'db61561fc456037cc9f0b83931fd88fb7ddeead3d86898d0bba5a7891143013a')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:990', @guest_id, 'Guest', 'Imported Record 0989', 'Australia', 'AU', 'Standard Double', 8, 'mid', 10920, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0990', 'AU', 'Australia', 'd2107f8888d412550c63decba3d8db11fba7a4e2b1858633687f442f1b42d555')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:991', @guest_id, 'Guest', 'Imported Record 0990', 'Australia', 'AU', 'Superior Double', 6, 'low', 8814, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0991', 'EG', 'Egypt', 'd857a55d1e30490c7647b33e24574881f277cfb96e47c0d0835885896315ea0b')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:992', @guest_id, 'Guest', 'Imported Record 0991', 'Egypt', 'EG', 'Grand Lit', 6, 'low', 7974, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0992', 'IN', 'India', '4f27c51fbfd11b8bafa232148751b1143e387b175bf03067c6e74b4455931dac')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:993', @guest_id, 'Guest', 'Imported Record 0992', 'India', 'IN', 'Suite', 6, 'high', 20808, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0993', 'SE', 'Sweden', 'ad280f0cf0407b10bef31d3c31af7d0308ab1ed89ad6558ec611ac5909d90345')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:994', @guest_id, 'Guest', 'Imported Record 0993', 'Sweden', 'SE', 'Standard Single', 2, 'high', 2588, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0994', 'KR', 'South Korea', 'f9113d36afe45fb304e8e2da5b38001e198d2be5fa19263b8b76d57e90863077')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:995', @guest_id, 'Guest', 'Imported Record 0994', 'South Korea', 'KR', 'LOFT Suite', 6, 'low', 20748, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0995', 'KR', 'South Korea', '59acd8906cfb4f283429745a1c7640b78ae7fe27bacb8c6f574c5a99b1fd15e8')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:996', @guest_id, 'Guest', 'Imported Record 0995', 'South Korea', 'KR', 'Suite', 9, 'mid', 27873, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0996', 'RU', 'Russia', 'e43a282853888536117b071e4cfb653b716726b8104271d28da0e49dfc2312b5')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:997', @guest_id, 'Guest', 'Imported Record 0996', 'Russia', 'RU', 'Suite', 7, 'high', 24220, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0997', 'SE', 'Sweden', 'a06c6e9fe47c1073bc560120e44c312130222b47107d8fddc466ef011d0e28c1')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:998', @guest_id, 'Guest', 'Imported Record 0997', 'Sweden', 'SE', 'Standard Single', 3, 'mid', 3651, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0998', 'VN', 'Vietnam', '917a835e6fcd66dc798b826896925a325a3c12cd38a05118c8d68ba56aa8ca4c')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:999', @guest_id, 'Guest', 'Imported Record 0998', 'Vietnam', 'VN', 'Superior Double', 3, 'mid', 5757, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 0999', 'IT', 'Italy', '8c8863c28551e8efe01a4b334089a222d1ffa3585ec0b719704ac5619f54ac21')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:1000', @guest_id, 'Guest', 'Imported Record 0999', 'Italy', 'IT', 'Standard Double', 4, 'low', 4808, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)
VALUES ('Guest', 'Imported Record 1000', 'CA', 'Canada', '4b5f5a4c78863cd36165f189776480407fb7d8417cdc8b551c9f6ea3eb9793a7')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
SET @guest_id = LAST_INSERT_ID();
INSERT INTO customer_stay_records
    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)
VALUES (@import_batch_id, 'Sheet1:1001', @guest_id, 'Guest', 'Imported Record 1000', 'Canada', 'CA', 'Suite', 4, 'low', 10740, 'accepted')
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
INSERT INTO import_batches
    (source_system, file_name, file_sha256, row_count, accepted_count, rejected_count, status)
VALUES ('ITAKEA/hoteldata', 'drinks_menu_with_sales.xlsx', '74d1bdea99746183477e329ee76f4cb65d1abcb8b014e9738f01a7cebe95b347', 30, 30, 0, 'completed')
ON DUPLICATE KEY UPDATE
    id = LAST_INSERT_ID(id), imported_at = CURRENT_TIMESTAMP,
    row_count = VALUES(row_count), accepted_count = VALUES(accepted_count),
    rejected_count = VALUES(rejected_count), status = VALUES(status);
SET @import_batch_id = LAST_INSERT_ID();
INSERT INTO bar_products (name, category, price, active)
VALUES ('Margarita', 'cocktail', 72.47, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:2', @product_id, 'Margarita', 'cocktail', 72.47, 2361, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Mojito', 'cocktail', 142.38, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:3', @product_id, 'Mojito', 'cocktail', 142.38, 3350, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Old Fashioned', 'cocktail', 129.16999999999999, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:4', @product_id, 'Old Fashioned', 'cocktail', 129.16999999999999, 3154, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Martini', 'cocktail', 132.16999999999999, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:5', @product_id, 'Martini', 'cocktail', 132.16999999999999, 3754, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Daiquiri', 'cocktail', 102.44, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:6', @product_id, 'Daiquiri', 'cocktail', 102.44, 3469, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Negroni', 'cocktail', 149.47999999999999, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:7', @product_id, 'Negroni', 'cocktail', 149.47999999999999, 2691, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Whiskey Sour', 'cocktail', 95.73, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:8', @product_id, 'Whiskey Sour', 'cocktail', 95.73, 3824, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Cosmopolitan', 'cocktail', 91.4, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:9', @product_id, 'Cosmopolitan', 'cocktail', 91.4, 2594, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Mai Tai', 'cocktail', 76.400000000000006, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:10', @product_id, 'Mai Tai', 'cocktail', 76.400000000000006, 2279, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Pina Colada', 'cocktail', 111.06, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:11', @product_id, 'Pina Colada', 'cocktail', 111.06, 3699, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Bloody Mary', 'cocktail', 127.2, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:12', @product_id, 'Bloody Mary', 'cocktail', 127.2, 3632, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Gin and Tonic', 'cocktail', 127.06, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:13', @product_id, 'Gin and Tonic', 'cocktail', 127.06, 3602, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Sidecar', 'cocktail', 103.96, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:14', @product_id, 'Sidecar', 'cocktail', 103.96, 2457, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Manhattan', 'cocktail', 86.61, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:15', @product_id, 'Manhattan', 'cocktail', 86.61, 2413, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Espresso Martini', 'cocktail', 86.15, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:16', @product_id, 'Espresso Martini', 'cocktail', 86.15, 3763, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('French 75', 'cocktail', 134.31, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:17', @product_id, 'French 75', 'cocktail', 134.31, 3168, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Caipirinha', 'cocktail', 106.43, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:18', @product_id, 'Caipirinha', 'cocktail', 106.43, 2802, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Mint Julep', 'cocktail', 143.54, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:19', @product_id, 'Mint Julep', 'cocktail', 143.54, 3653, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Tom Collins', 'cocktail', 104.27, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:20', @product_id, 'Tom Collins', 'cocktail', 104.27, 3344, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Long Island Iced Tea', 'cocktail', 146.22999999999999, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:21', @product_id, 'Long Island Iced Tea', 'cocktail', 146.22999999999999, 2068, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Espresso', 'coffee', 69.099999999999994, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:22', @product_id, 'Espresso', 'coffee', 69.099999999999994, 14656, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Americano', 'coffee', 40.840000000000003, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:23', @product_id, 'Americano', 'coffee', 40.840000000000003, 13833, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Latte', 'coffee', 63.19, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:24', @product_id, 'Latte', 'coffee', 63.19, 11355, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Cappuccino', 'coffee', 50.87, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:25', @product_id, 'Cappuccino', 'coffee', 50.87, 11676, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Macchiato', 'coffee', 61.41, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:26', @product_id, 'Macchiato', 'coffee', 61.41, 10389, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Mocha', 'coffee', 60.59, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:27', @product_id, 'Mocha', 'coffee', 60.59, 13897, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Flat White', 'coffee', 33.43, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:28', @product_id, 'Flat White', 'coffee', 33.43, 10249, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Cortado', 'coffee', 54.5, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:29', @product_id, 'Cortado', 'coffee', 54.5, 10354, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Iced Coffee', 'coffee', 34.79, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:30', @product_id, 'Iced Coffee', 'coffee', 34.79, 10337, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
INSERT INTO bar_products (name, category, price, active)
VALUES ('Affogato', 'coffee', 63.6, TRUE)
ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;
SET @product_id = LAST_INSERT_ID();
INSERT INTO customer_bar_sales_aggregates
    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)
VALUES (@import_batch_id, 'Sheet1:31', @product_id, 'Affogato', 'coffee', 63.6, 11135, 'accepted')
ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;
COMMIT;
