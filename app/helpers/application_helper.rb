module ApplicationHelper

  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error:   'alert-error',
    alert:   'alert-block',
    notice:  'alert-info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym)
  end

end
