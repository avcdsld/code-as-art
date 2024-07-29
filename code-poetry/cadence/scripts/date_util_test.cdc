import "DateUtil"

access(all) fun main() {
    assert(DateUtil.isJuly7(1688687999.0) == false, message: "2023-07-06 23:59:59 UTC")
    assert(DateUtil.isJuly7(1688688000.0) == true, message: "2023-07-07 00:00:00 UTC")
    assert(DateUtil.isJuly7(1688720400.0) == true, message: "2023-07-07 09:00:00 UTC")
    assert(DateUtil.isJuly7(1688774399.0) == true, message: "2023-07-07 23:59:59 UTC")
    assert(DateUtil.isJuly7(1688774400.0) == false, message: "2023-07-08 00:00:00 UTC")

    assert(DateUtil.isJuly7(1720310399.0) == false, message: "2024-07-06 23:59:59 UTC")
    assert(DateUtil.isJuly7(1720310400.0) == true, message: "2024-07-07 00:00:00 UTC")
    assert(DateUtil.isJuly7(1720396799.0) == true, message: "2024-07-07 23:59:59 UTC")
    assert(DateUtil.isJuly7(1720396800.0) == false, message: "2024-07-08 00:00:00 UTC")

    assert(DateUtil.isJuly7(1751846400.0) == true, message: "2025-07-07 00:00:00 UTC")
    assert(DateUtil.isJuly7(1751932799.0) == true, message: "2025-07-07 23:59:59 UTC")

    assert(DateUtil.isJuly7(1783382400.0) == true, message: "2026-07-07 00:00:00 UTC")
    assert(DateUtil.isJuly7(1783468799.0) == true, message: "2026-07-07 23:59:59 UTC")

    assert(DateUtil.isJuly7(1814918400.0) == true, message: "2027-07-07 00:00:00 UTC")
    assert(DateUtil.isJuly7(1815004799.0) == true, message: "2027-07-07 23:59:59 UTC")

    assert(DateUtil.isJuly7(7274275199.0) == false, message: "2200-07-06 23:59:59 UTC")
    assert(DateUtil.isJuly7(7274275200.0) == true, message: "2200-07-07 00:00:00 UTC")
    assert(DateUtil.isJuly7(7274361599.0) == true, message: "2200-07-07 23:59:59 UTC")
    assert(DateUtil.isJuly7(7274361600.0) == false, message: "2200-07-08 00:00:00 UTC")
}
