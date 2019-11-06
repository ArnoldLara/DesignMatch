module ProjectHelper

  def handleState(is_available)
    if is_available == true
      'Available'
    else
      'Being processed'
    end
  end
end
