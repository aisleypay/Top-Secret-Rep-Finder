#!/usr/bin/env ruby

require_relative '../config/environment'

welcome
address = get_address_from_user
info = show_representative_info(address)
