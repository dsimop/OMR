# Optical Music Recognition and Audio Samples Creation

This system is able to recognise single-stave music scores and create audio files from them.

## Getting Started

The user has to open the `main.m` in order to start the system.
In the 4th line, the user has to specify the path of the image.
After setting up correctly the path, the code can be executed.

All the tested images were created with `MuseScore`, which is provided under the GNU GPL License.

After inserting the correct image path into the `main.m` and running it, a `recogniseScore` variable is created, which contains all the necessary information for the music score excluding the dynamics (like the mf and ff).

The created audio sample is located in the `Scores` folder and it is exported with the name `NewAudioSample.wav`.

### Prerequisites

`MATLAB` is required in order to run the current project.
`MuseScore` is optional, in order to create new music scores.

The exported .png format from MuseScore, produces an image with transparency.
To remove the transparency, `GIMP` Image Editor can be used.
In that case, the following steps have to be followed:

```
Open the image with GIMP
Right click on the image -> Layer -> Transparency -> Remove Alpha Channel
Overwrite the current image
```

##### Author
Dimitrios Simopoulos

##### Supervisor
Prof. Ela Claridge

##### Copyrights: 
- Dimitrios Simopoulos
- University of Birmingham, UK
