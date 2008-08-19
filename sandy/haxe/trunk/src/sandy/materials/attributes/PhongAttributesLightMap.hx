//Used in a few attributes
package sandy.materials.attributes;
class PhongAttributesLightMap
{
	public var alphas:Array<Array<Dynamic>>;
	public var colors:Array<Array<UInt>>;
	public var ratios:Array<Array<Dynamic>>;

    public function new () {
	 alphas = [[], []];
	 colors = [[], []];
	 ratios = [[], []];
    }
}
