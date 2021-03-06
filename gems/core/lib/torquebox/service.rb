# Copyright 2008-2012 Red Hat, Inc, and individual contributors.
#
# This is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation; either version 2.1 of
# the License, or (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this software; if not, write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA, or see the FSF site: http://www.fsf.org.

module TorqueBox
  class Service
    class << self

      def list
        prefix = service_prefix.canonical_name
        suffix = '.create'
        service_names = TorqueBox::MSC.service_names.select do |service_name|
          name = service_name.canonical_name
          name.start_with?(prefix) && name.end_with?(suffix)
        end
        service_names.map do |service_name|
          TorqueBox::MSC.get_service(service_name).value
        end
      end

      def lookup(name)
        service_name = service_prefix.append(name).append('create')
        service = TorqueBox::MSC.get_service(service_name)
        service.nil? ? nil : service.value
      end

      private

      def service_prefix
        TorqueBox::MSC.deployment_unit.service_name.append('service')
      end

    end
  end
end
