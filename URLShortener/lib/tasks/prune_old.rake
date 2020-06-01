namespace :maintenance do
    namespace :shortened_url do
        desc 'prune_old_urls'
            task :prune_old do
                ShortenedUrl.prune(1000)
            end
        end
    end
end 