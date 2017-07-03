module Sightengine
  module Api
    module FaceAttributes
      class Face
        attr_accessor :x1, :y1, :x2, :y2
        attr_accessor :features
        attr_accessor :attributes

        def initialize(hash)
          hash.each do |k, v|
            send("#{k}=", v)
          end
        end

        def coordinates
          [x1, y1, x2, y2]
        end

        def female?(min_prob = 0.8)
          attributes["female"].to_f > min_prob
        end

        def male?(min_prob = 0.8)
          attributes["male"].to_f > min_prob
        end

        def minor?(min_prob = 0.8)
          attributes["minor"].to_f > min_prob
        end

        def sunglasses?(min_prob = 0.8)
          attributes["minor"].to_f > min_prob
        end
      end

      class Response < ::Sightengine::Api::Response
        attr_accessor :faces
        
        def faces
          (self.instance_variable_get("@faces") || []).map do |face|
            Face.new(face)
          end
        end
      end

      def face_attributes(image_url)
        Response.new(do_check(image_url, ["face-attributes"]))
      end
    end
  end
end