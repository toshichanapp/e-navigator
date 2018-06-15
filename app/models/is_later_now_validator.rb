class IsLaterNowValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value < Time.zone.now
      record.errors.add(attribute, 'は未来の時間を指定してください')
    end
  end
end
