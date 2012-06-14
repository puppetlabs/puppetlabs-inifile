Puppet::Type.newtype(:ini_setting) do

  ensurable do
    defaultvalues
    defaultto :present
  end
end