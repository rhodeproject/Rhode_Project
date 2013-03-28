module SponsorsHelper
  def show_label(label)
      label + " sponsor" unless label == "" || label.nil?
  end
end
