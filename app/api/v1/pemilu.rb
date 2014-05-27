module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :stamps do     
      
      desc "Return all Stamps"
      get do
        stamps = Array.new
        
        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 50 : params[:limit]
        
        valid_params = {
          tag: "tags.tag"
        }
        
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end
        
        Stamp.includes(:tags)
          .where(conditions)          
          .limit(limit)
          .offset(params[:offset])
          .each do |stamp|
            stamps << {
              id: stamp.id,
              nama: stamp.nama,
              url_preview: stamp.url_preview,
              width_preview: stamp.width_preview,
              heigth_preview: stamp.height_preview,
              url_full: stamp.url_full,
              width_full: stamp.width_full,
              height_full: stamp.height_full,
              tags: stamp.tags.map { |tag| tag.tag }
            }
          end
          {
          results: {
            count: stamps.count,
            total: Stamp.includes(:tags).where(conditions).count,
            stamps: stamps
          }
        }
      end
      
      desc "Return a single Stamp object with all its details"
      params do
        requires :id, type: String, desc: "Stamp ID."
      end
      route_param :id do
        get do
          stamp = Stamp.find_by(id: params[:id])
          {
            results: {
              count: 1,
              total: 1,
              stamp: [{
                id: stamp.id,
                nama: stamp.nama,
                url_preview: stamp.url_preview,
                width_preview: stamp.width_preview,
                heigth_preview: stamp.height_preview,
                url_full: stamp.url_full,
                width_full: stamp.width_full,
                height_full: stamp.height_full,
                tags: stamp.tags.map { |tag| tag.tag }
              }]
            }
          }
        end
      end
    end
    
    resource :tags do
      desc 'return a list of Tags objects'
      get do
        tags = Array.new
        Tag.group('tag').count.each do |field|
          tags << {
            tag: field[0],
            question_count: field[1]
          }
        end
        {
          results: {
            count: tags.count,            
            tags: tags
          }
        }
      end
    end
  end
end