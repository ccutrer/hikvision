# frozen_string_literal: true

module Hikvision
  class System
    add_xml(:status, "/ISAPI/System/status")

    add_getter(:uptime, :status, "deviceUpTime", { cache: false }, &:to_i)

    add_list_getter(:memory_usage, :status, "MemoryList/Memory/memoryUsage", { cache: false }, &:to_i)
    add_list_getter(:memory_available, :status, "MemoryList/Memory/memoryAvailable", { cache: false }, &:to_i)
    add_list_getter(:memory_description, :status, "MemoryList/Memory/memoryDescription")
    add_list_getter(:cpu_utilization, :status, "CPUList/CPU/cpuUtilization", { cache: false }, &:to_i)
    add_list_getter(:cpu_description, :status, "CPUList/CPU/cpuDescription")
  end
end
