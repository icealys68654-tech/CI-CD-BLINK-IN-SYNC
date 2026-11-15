# CI/CD BLINK IN SYNC — Roblox Studio

A Roblox Studio starter project that visualizes a CI/CD pipeline with interactive checkpoints and a deployment gate.

## Installation

1. Open your place in Roblox Studio.
2. Select **View → Command Bar**.
3. Paste the contents of `Build_CICD_BlinkInSync.lua` into the Command Bar and press **Enter**.
4. Press **Play**, then press **E** at each station in order: **BUILD**, **TEST**, **VALIDATE**, and **DEPLOY**.

## Included Features

- Floating island blockout with grass, cliff face, and water.
- Main CI/CD billboard and cyan synchronization rail.
- Four connected station assemblies with ProximityPrompts.
- Server-side sequential checkpoint progression.
- Deployment gate that remains locked until BUILD, TEST, and VALIDATE pass.
- Player attributes `CICDProgress` and `CICDStatus` for a future HUD.

## Replacing the Blockout with MeshParts

This starter creates a functional Parts-based blockout. It does not include an imported FBX or a fabricated Roblox MeshId. To replace the blockout with your designed low-poly MeshParts:

1. Export your environment from your DCC tool as an FBX.
2. Import it with Roblox Studio's **3D Importer**.
3. Move the imported MeshParts into `Workspace.CICD_BlinkInSync`.
4. Keep the named interaction pads, ProximityPrompts, and `Deployment_Gate`.
5. Anchor static environment meshes. For a movable assembly, unanchor the meshes and connect them to `Island_Core` with WeldConstraints.

## Production Limitations

- Checkpoint progress is held in server memory and resets when a player leaves or the server restarts.
- The checkpoint stages simulate a pipeline; they do not execute external CI builds, tests, or deployments.
- Before publishing, add a client HUD that reads `CICDStatus` and `CICDProgress`, persistence if required, and exploit testing.
