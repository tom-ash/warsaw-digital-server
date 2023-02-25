# frozen_string_literal: true

module SkillfindTech
  class CovetedSkill < ApplicationRecord
    establish_connection :skillfind_tech

    self.table_name = 'coveted_skills'
    # TODO: Add unique index on :job_id & :skill_id.

    belongs_to :job
    belongs_to :skill

    validates :skill, presence: true
    validates :level, presence: true, numericality: true
  end
end