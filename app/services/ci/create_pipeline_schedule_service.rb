module Ci
  class CreatePipelineScheduleService < BaseService
    def execute
      pipeline_schedule = project.pipeline_schedules.build(pipeline_schedule_params)

      if Ci::NestedUniquenessValidator.duplicated?(pipeline_schedule_params['variables_attributes'], 'key')
        pipeline_schedule.errors.add('variables.key', "keys are duplicated")

        return pipeline_schedule
      end

      pipeline_schedule.save
      pipeline_schedule
    end

    private

    def pipeline_schedule_params
      @pipeline_schedule_params ||= params.merge(owner: current_user)
    end
  end
end
