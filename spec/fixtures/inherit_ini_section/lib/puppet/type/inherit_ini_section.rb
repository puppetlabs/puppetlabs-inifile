Puppet::Type.newtype(:inherit_ini_section) do
  ensurable
  newparam(:section, namevar: true)
  newproperty(:value)
end
