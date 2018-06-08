class InterviewDateValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    Rails.logger.debug(value)
    Rails.logger.debug(Time.zone.now)
    if value < Time.zone.now
      record.errors.add(attribute, 'は未来の時間を指定してください')
    end
  end
end
