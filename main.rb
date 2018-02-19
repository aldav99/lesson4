require_relative 'train'
require_relative 'station'
require_relative 'route'

stations = []
trains = [] 
routes = {}

def trains_content(arr)
  arr.each { |element| print "#{element.name}   " }
end

def routes_content(hash)
  hash.each do |id, value|
      puts "#{id}"
      value.stations.each { |station| puts "#{station.name}" }
  end
end

pw = PassengerWagon.new
cw = CargoWagon.new

loop do

  puts "Что Вы хотите сделать?"
  puts "-- Введите 'станция' для добавления станции."
  puts "-- Введите 'список станций' для просмотра списка станций."
  puts "-- Введите 'поезд' для добавления поезда."
  puts "-- Введите 'маршрут' для создания маршрута."
  puts "-- Введите 'список маршрутов' для просмотра маршрутов."
  puts "-- Введите 'добавить в маршрут' для добавления станции в маршрут."
  puts "-- Введите 'удалить из маршрута' для удаления станции из маршрута."
  puts "-- Введите 'назначить маршрут' для назначения маршрута поезду."
  puts "-- Введите 'поезда на станции' для просмотра поездов на станции."
  puts "-- Введите 'поезд вперед' для продвижения поезда вперед на одну станцию."
  puts "-- Введите 'поезд назад' для продвижения поезда назад на одну станцию."
  puts "-- Введите 'добавить вагон' для добавления вагона к поезду."
  puts "-- Введите 'отцепить вагон' для отцепления вагона от поезда."
  puts "-- Введите 'стоп' для выхода из программы."

  choice = gets.chomp.downcase

  case choice

  when "станция"
    puts "Введите название станции"
    station = gets.chomp
    stations << Station.new(station)
  when "список станций"
    puts "Список пуст" if stations.empty?
    stations.each_index { |index| puts "#{index}     #{stations[index].name}" }
  when "поезд"
    puts "Введите название поезда"
    train = gets.chomp
    puts "Введите тип поезда (1 - Пассажирский или 2 - Грузовой)"
    type = gets.to_i
    if type == 1
      trains << PassengerTrain.new(train)
    elsif type == 2
      trains << CargoTrain.new(train)
    else
      puts "Нет такого типа"
    end
  when "маршрут"
    puts "Введите номер маршрута"
    id = gets.to_i
    puts "Введите номер начальной станции из списка станций"
    start = gets.to_i
    puts "Введите номер конечной станции из списка станций"
    terminate = gets.to_i
    routes[id] = Route.new(stations[start], stations[terminate])
  when "список маршрутов"
    puts "Список пуст" if routes.empty?
    routes_content(routes)
  when "добавить в маршрут"
    puts "Введите номер маршрута"
    id = gets.to_i
    puts "Введите номер станции из списка станций для добавления"
    station_index = gets.to_i
    station = stations[station_index]
    if routes[id].stations.include?(station)
      puts "Такая станция уже есть в маршруте"  
    else 
      routes[id].add_station(station)
    end 
  when "удалить из маршрута"
    puts "Введите номер маршрута"
    id = gets.to_i
    puts "Выберите станцию для удаления"
    routes[id].stations.each { |station| puts "#{station.name}" }
    station = gets.chomp
    if routes[id].delete_station(station)
      puts "Удалена станция #{station}"
    else
      puts "Конечные точки нельзя удалять"
    end
  when "назначить маршрут"
    puts "Выберите поезд из списка поездов"
    trains_content(trains)
    puts
    train_name = gets.chomp
    puts "Выберите маршрут из списка маршрутов"
    routes_content(routes)
    puts
    id = gets.to_i
    route = routes[id]
    trains.each { |train| train.route=(route) if train.name == train_name}
  when "поезда на станции"
    puts "Введите номер станции из списка станций"
    station_index = gets.to_i
    station = stations[station_index]
    station.list_of_trains
  when "поезд вперед"
    puts "Выберите поезд из списка поездов"
    trains_content(trains)
    train_name = gets.chomp
    trains.each { |train| train.go_forward if train.name == train_name }
  when "поезд назад"
    puts "Выберите поезд из списка поездов"
    trains_content(trains)
    puts
    train_name = gets.chomp
    trains.each { |train| train.go_back if train.name == train_name }
  when "добавить вагон"
    puts "Выберите поезд из списка поездов"
    trains_content(trains)
    puts
    train_name = gets.chomp
    trains.each do |train| 
      if train.type == cw.type 
        train.attach_wagon(cw)
      puts train.wagons.size
      else 
        train.attach_wagon(pw)
        puts train.wagons.size
      end
    end
  when "отцепить вагон"
    puts "Выберите поезд из списка поездов"
    trains_content(trains)
    puts
    train_name = gets.chomp
    trains.each do |train| 
      if train.name == train_name
        train.deattach_wagon
        puts train.wagons.size
      end
    end
  when "стоп"
    break
  else
    puts "Error!"
  end
end





