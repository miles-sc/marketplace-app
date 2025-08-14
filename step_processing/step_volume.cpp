#include <STEPControl_Reader.hxx>
#include <TopoDS.hxx>
#include <TopoDS_Solid.hxx>
#include <BRepGProp.hxx>
#include <GProp_GProps.hxx>
#include <iostream>


int main(int argc, char** argv) {
  if (argc != 2) {
    std::cerr << "Usage: step_volume file.step\n";
    return 1;
  }
  // load step file
  STEPControl_Reader reader;
  if (reader.ReadFile(argv[1]) != IFSelect_RetDone) {
    std::cerr << "Error: cannot read STEP\n";
    return 1;
  }
    reader.TransferRoots();

  // turn it into a solid
  TopoDS_Shape shape = reader.OneShape();
  TopoDS_Solid solid = TopoDS::Solid(shape);

  // compute volume
  GProp_GProps props;
  BRepGProp::VolumeProperties(solid, props);

  // print
  std::cout << props.Mass() << std::endl;
  return 0;
}
