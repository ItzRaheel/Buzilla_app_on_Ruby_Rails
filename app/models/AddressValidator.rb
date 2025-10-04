class AddressValidator < ActiveModel::Validator
  def validate(record)
    if record.description.blank?
      record.errors.add :description, "is required"
    end
    
    if record.name.blank?
      record.errors.add :name,"is required"
    end
    if record.file.blank?
      record.errors.add :file,"is required : "
    end
    if record.bug_status.blank?
      record.errors.add :bug_status,"is required "
    end
    if record.description.length <= 30
      record.errors.add :description ,"The des length b/w 6 to 30:"
    end
  




#     if record.street.blank?
#       record.errors.add :street, "is required"
#     end

#     if record.postcode.blank?
#       record.errors.add :postcode, "is required"
#     end
  end
end