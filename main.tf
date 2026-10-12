resource "snowflake_stream_on_table" "stream_on_tables" {
  for_each = var.stream_on_tables

  database          = each.value.database
  name              = each.value.name
  schema            = each.value.schema
  table             = each.value.table
  append_only       = each.value.append_only
  comment           = each.value.comment
  copy_grants       = each.value.copy_grants
  show_initial_rows = each.value.show_initial_rows

  dynamic "at" {
    for_each = each.value.at != null ? [each.value.at] : []
    content {
      offset    = at.value.offset
      statement = at.value.statement
      stream    = at.value.stream
      timestamp = at.value.timestamp
    }
  }

  dynamic "before" {
    for_each = each.value.before != null ? [each.value.before] : []
    content {
      offset    = before.value.offset
      statement = before.value.statement
      stream    = before.value.stream
      timestamp = before.value.timestamp
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

