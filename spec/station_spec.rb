require 'station'

describe Station do 
  it 'stores name in name variable' do
    station = Station.new("station1", 1)
    expect(station.station_name).to eq "station1"
  end

  it 'stores zone in zone variable' do
    station = Station.new("station1", 1)
    expect(station.zone).to eq 1
  end

end 