
package sandy.view;

/**
* Used to identify the culling state of an object.
*
* <p>A 3D object can be completely or partly inside the frustum of the camera,
* or completely outside of it.</p>
*
* @author		Thomas Pfeiffer - kiroukou
* @author		Niel Drummond - haXe port
* @version		3.1
* @date 		26.07.2007
*/
enum CullingState
{
		INTERSECT;
		INSIDE;
		OUTSIDE;
}

