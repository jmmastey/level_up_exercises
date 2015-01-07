module LegislatorsHelper
  def legislator_image_tag(legislator)
    image = Dir.glob('app/assets/images/legislators/150/*.jpg')
      .sample.sub('app/assets/images/', '')
    image_tag(image)
  end
end
