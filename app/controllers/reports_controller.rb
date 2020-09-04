class ReportsController < ApplicationController

  api :GET, 'reports/infected_percentage', '
    Shows a percentage of infected people
  '
  def infected_percentage
    infected = Person.zombie_total

    return render json: {
      percentage: 0
    } if infected == 0

    percentage = Person.count.to_f / infected.to_f * 100.00

    render json: { percentage: "#{percentage}%" }
  end

  api :GET, 'reports/healthy_percentage', '
    Shows a percentage of healthy people
  '
  def healthy_percentage
    healthy = Person.healthy_total

    return render json: {
      percentage: 0
    } if healthy == 0

    percentage = Person.count.to_f / healthy.to_f * 100.00

    render json: { percentage: "#{percentage}%" }
  end

  api :GET, 'reports/current_position', '
    Shows the current inventory position
  '
  def current_position
    render json: { position: Inventory.current_position }
  end

  api :GET, 'reports/lost_points', '
    Shows how many points where lost because of infection
  '
  def lost_points
    render json: { lost_points: Inventory.lost_points }
  end

  api :GET, 'reports/average_resources', '
    Shows the average amount of resources by healthy person
  '
  def average_resources
    render json: { average: Inventory.average_resources }
  end
end
