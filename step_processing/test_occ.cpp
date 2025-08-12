#include <BRepPrimAPI_MakeBox.hxx>
#include <GProp_GProps.hxx>
#include <BRepGProp.hxx>
#include <TopoDS_Solid.hxx>
#include <iostream>

int main() {
    // create the box-maker
    BRepPrimAPI_MakeBox maker(10.0, 20.0, 30.0);

    // create solid
    TopoDS_Solid box = maker.Solid();

    // compute volume
    GProp_GProps system;
    BRepGProp::VolumeProperties(box, system);
    std::cout << "Volume: " << system.Mass() << std::endl;

    return 0;
}
