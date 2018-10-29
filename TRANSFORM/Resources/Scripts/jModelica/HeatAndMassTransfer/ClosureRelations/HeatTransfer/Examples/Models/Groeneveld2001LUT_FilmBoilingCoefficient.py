from pymodelica import compile_fmu
from pyfmi import load_fmu

libPath = r'C:\Users\vmg\Documents\Modelica\TRANSFORM-Library/TRANSFORM'
modelName = 'TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Examples.Models.Groeneveld2001LUT_FilmBoilingCoefficient'

fmu = compile_fmu(modelName,libPath,target='cs')
model = load_fmu(fmu)

result = model.simulate()
