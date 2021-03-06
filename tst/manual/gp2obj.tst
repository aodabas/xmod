#############################################################################
##
#W  gp2obj.tst                    XMOD test file                Chris Wensley
#W                                                                & Murat Alp
#Y  Copyright (C) 2001-2019, Chris Wensley et al, 
#Y  School of Computer Science, Bangor University, U.K. 
##
gap> START_TEST( "XMod package: gp2obj.tst" );
gap> saved_infolevel_xmod := InfoLevel( InfoXMod );; 
gap> SetInfoLevel( InfoXMod, 0 );
gap> saved_infolevel_groupoids := InfoLevel( InfoGroupoids );; 
gap> SetInfoLevel( InfoGroupoids, 0 );;

## Chapter 2,  Section 2.1.2
gap> c5 := Group( (5,6,7,8,9) );;
gap> SetName( c5, "c5" );
gap> id5 := IdentityMapping( c5 );;
gap> ac5 := AutomorphismGroup( c5 );; 
gap> act := MappingToOne( c5, ac5 );;
gap> XMod( id5, act ) = XModByBoundaryAndAction( id5, act );
true

## Section 2.1.3
gap> q8 := QuaternionGroup( IsPermGroup, 8 );
Group([ (1,5,3,7)(2,8,4,6), (1,2,3,4)(5,6,7,8) ])
gap> SetName( q8, "q8" );
gap> c2 := Centre( q8 );                     
Group([ (1,3)(2,4)(5,7)(6,8) ])
gap> SetName( c2, "<-1>" );
gap> bdy := InclusionMappingGroups( q8, c2 );;
gap> X8a := XModByTrivialAction( bdy );
[<-1>->q8]
gap> c4 := Subgroup( q8, [q8.1] );;
gap> SetName( c4, "<i>" );
gap> X8b := XModByNormalSubgroup( q8, c4 );
[<i>->q8]
gap> Display(X8b);        

Crossed module [<i>->q8] :- 
: Source group has generators:
  [ (1,5,3,7)(2,8,4,6) ]
: Range group q8 has generators:
  [ (1,5,3,7)(2,8,4,6), (1,2,3,4)(5,6,7,8) ]
: Boundary homomorphism maps source generators to:
  [ (1,5,3,7)(2,8,4,6) ]
: Action homomorphism maps range generators to automorphisms:
  (1,5,3,7)(2,8,4,6) --> { source gens --> [ (1,5,3,7)(2,8,4,6) ] }
  (1,2,3,4)(5,6,7,8) --> { source gens --> [ (1,7,3,5)(2,6,4,8) ] }
  These 2 automorphisms generate the group of automorphisms.

## Section 2.1.4
gap> X5 := XModByAutomorphismGroup( c5 );
[c5->Aut(c5)]
gap> Display( X5 );

Crossed module [c5->Aut(c5)] :- 
: Source group c5 has generators:
  [ (5,6,7,8,9) ]
: Range group Aut(c5) has generators:
  [ GroupHomomorphismByImages( c5, c5, [ (5,6,7,8,9) ], [ (5,7,9,6,8) ] ) ]
: Boundary homomorphism maps source generators to:
  [ IdentityMapping( c5 ) ]
: Action homomorphism maps range generators to automorphisms:
  GroupHomomorphismByImages( c5, c5, [ (5,6,7,8,9) ], 
[ (5,7,9,6,8) ] ) --> { source gens --> [ (5,7,9,6,8) ] }
  This automorphism generates the group of automorphisms.

## Section 2.1.5
gap> gen12 := [ (1,2,3,4,5,6), (2,6)(3,5) ];;
gap> d12 := Group( gen12 );;                  
gap> gen6 := [ (7,8,9), (8,9) ];;
gap> s3 := Group( gen6 );;
gap> pr12 := GroupHomomorphismByImages( d12, s3, gen12, gen6 );;
gap> Kernel( pr12 ) = Centre( d12 );
true
gap> X12 := XModByCentralExtension( pr12 );;
gap> Display( X12 );                         

Crossed module :- 
: Source group has generators:
  [ (1,2,3,4,5,6), (2,6)(3,5) ]
: Range group has generators:
  [ (7,8,9), (8,9) ]
: Boundary homomorphism maps source generators to:
  [ (7,8,9), (8,9) ]
: Action homomorphism maps range generators to automorphisms:
  (7,8,9) --> { source gens --> [ (1,2,3,4,5,6), (1,3)(4,6) ] }
  (8,9) --> { source gens --> [ (1,6,5,4,3,2), (2,6)(3,5) ] }
  These 2 automorphisms generate the group of automorphisms.

## Section 2.1.6
gap> gens4 := [ (11,12), (12,13), (13,14) ];; 
gap> s4 := Group( gens4 );; 
gap> theta := GroupHomomorphismByImages( s4, s3, gens4, [(7,8),(8,9),(7,8)] );;
gap> X1 := XModByPullback( X12, theta );; 
gap> StructureDescription( Source( X1 ) );
"C2 x S4"
gap> info := PullbackInfo( Source( X1 ) );;
gap> info!.directProduct;
Group([ (1,2,3,4,5,6), (2,6)(3,5), (7,8), (8,9), (9,10) ])
gap> info!.projections[1];
[ (7,8)(9,10), (7,9)(8,10), (2,6)(3,5)(8,9), (1,5,3)(2,6,4)(8,10,9), 
  (1,6,5,4,3,2)(8,9,10) ] -> [ (), (), (2,6)(3,5), (1,5,3)(2,6,4), 
  (1,6,5,4,3,2) ]
gap> info!.projections[2];
[ (7,8)(9,10), (7,9)(8,10), (2,6)(3,5)(8,9), (1,5,3)(2,6,4)(8,10,9), 
  (1,6,5,4,3,2)(8,9,10) ] -> [ (11,12)(13,14), (11,13)(12,14), (12,13), 
  (12,14,13), (12,13,14) ]

## Section 2.1.8
gap> DirectProductOp( [X8a,X8b], X8a );
[<-1>x<i>->q8xq8]

## Section 2.1.9
gap> Source( X12 );   
Group([ (1,2,3,4,5,6), (2,6)(3,5) ])
gap> Range( X12 );    
Group([ (7,8,9), (8,9) ])
gap> Boundary( X12 ); 
[ (1,2,3,4,5,6), (2,6)(3,5) ] -> [ (7,8,9), (8,9) ]
gap> XModAction( X12 );
[ (7,8,9), (8,9) ] -> 
[ [ (1,2,3,4,5,6), (2,6)(3,5) ] -> [ (1,2,3,4,5,6), (1,3)(4,6) ], 
  [ (1,2,3,4,5,6), (2,6)(3,5) ] -> [ (1,6,5,4,3,2), (2,6)(3,5) ] ]

## Section 2.1.11
gap> Size( X5 );
[ 5, 4 ]
gap> IdGroup( X5 ); 
[ [ 5, 1 ], [ 4, 1 ] ]
gap> ext := ExternalSetXMod( X5 ); 
<xset:[ (), (5,6,7,8,9), (5,7,9,6,8), (5,8,6,9,7), (5,9,8,7,6) ]>
gap> Orbits( ext );
[ [ () ], [ (5,6,7,8,9), (5,7,9,6,8), (5,9,8,7,6), (5,8,6,9,7) ] ]
gap> a := GeneratorsOfGroup( Range( X5 ) )[1]^2; 
[ (5,6,7,8,9) ] -> [ (5,9,8,7,6) ]
gap> ImageElmXModAction( X5, (5,7,9,6,8), a );
(5,8,6,9,7)
gap> Print( RepresentationsOfObject(X5), "\n" );
[ "IsComponentObjectRep", "IsAttributeStoringRep", "IsPreXModObj" ]
gap> Print( KnownAttributesOfObject(X5), "\n" );
[ "Name", "Size", "Range", "Source", "IdGroup", "Boundary", "XModAction", 
  "ExternalSetXMod", "IsomorphismPerm2DimensionalGroup" ]

## Section 2.2.1
gap> kpoX5 := KnownPropertiesOfObject(X5);;
gap> ForAll( [ "IsEmpty", "IsTrivial", "IsNonTrivial", "IsFinite", 
>  "CanEasilyCompareElements", "CanEasilySortElements", "IsDuplicateFree", 
>  "IsGeneratorsOfSemigroup", "IsPreXModDomain", "IsPerm2DimensionalGroup", 
>  "IsPreXMod", "IsXMod", "IsAutomorphismGroup2DimensionalGroup" ], 
>  s -> s in kpoX5 ); 
true

## Section 2.2.2
gap> s4 := Group( (1,2), (2,3), (3,4) );; 
gap> a4 := Subgroup( s4, [ (1,2,3), (2,3,4) ] );; 
gap> k4 := Subgroup( a4, [ (1,2)(3,4), (1,3)(2,4) ] );; 
gap> SetName(s4,"s4");  SetName(a4,"a4");  SetName(k4,"k4"); 
gap> X4 := XModByNormalSubgroup( s4, a4 );
[a4->s4]
gap> Y4 := SubXMod( X4, k4, a4 ); 
[k4->a4]
gap> IsNormal( X4, Y4 ); 
true
gap> NX4 := NormalSubXMods( X4 );;
gap> Length( NX4 ); 
5

## Section 2.2.2
gap> d8d8 := Group( (1,2,3,4), (1,3), (5,6,7,8), (5,7) );;
gap> X88 := XModByAutomorphismGroup( d8d8 );;
gap> Size( X88 );
[ 64, 2048 ]
gap> Y88 := KernelCokernelXMod( X88 );;
gap> IdGroup(Y88);
[ [ 4, 2 ], [ 128, 928 ] ]

## Section 2.3.1
gap> b1 := (11,12,13,14,15,16,17,18);;  b2 := (12,18)(13,17)(14,16);;
gap> d16 := Group( b1, b2 );;
gap> sk4 := Subgroup( d16, [ b1^4, b2 ] );;
gap> SetName( d16, "d16" );  SetName( sk4, "sk4" );
gap> bdy16 := GroupHomomorphismByImages( d16, sk4, [b1,b2], [b1^4*b2,b2] );;
gap> aut1 := GroupHomomorphismByImages( d16, d16, [b1,b2], [b1^5,b2] );;
gap> aut2 := GroupHomomorphismByImages( d16, d16, [b1,b2], [b1,b1^4*b2] );;
gap> aut16 := Group( [ aut1, aut2 ] );;
gap> act16 := GroupHomomorphismByImages( sk4, aut16, [b1^4,b2], [aut1,aut2] );;
gap> P16 := PreXModByBoundaryAndAction( bdy16, act16 );
[d16->sk4]
gap> IsXMod( P16 );
false

## Section 2.3.2
gap> P := PeifferSubgroup( P16 );
Group([ (11,15)(12,16)(13,17)(14,18), (11,13,15,17)(12,14,16,18) ])
gap> X16 := XModByPeifferQuotient( P16 );
Peiffer([d16->sk4])
gap> Display( X16 );

Crossed module Peiffer([d16->sk4]) :- 
: Source group has generators:
  [ f1, f2 ]
: Range group has generators:
  [ (11,15)(12,16)(13,17)(14,18), (12,18)(13,17)(14,16) ]
: Boundary homomorphism maps source generators to:
  [ (12,18)(13,17)(14,16), (11,15)(12,14)(16,18) ]
  The automorphism group is trivial

gap> iso16 := IsomorphismPermGroup( Source( X16 ) );;
gap> S16 := Image( iso16 );
Group([ (1,2), (3,4) ])

## Section 2.4.1
gap> g18gens := [ (1,2,3), (4,5,6), (2,3)(5,6) ];;     
gap> s3agens := [ (7,8,9), (8,9) ];;                
gap> g18 := Group( g18gens );;  SetName( g18, "g18" ); 
gap> s3a := Group( s3agens );;  SetName( s3a, "s3a" );
gap> t1 := GroupHomomorphismByImages(g18,s3a,g18gens,[(7,8,9),(),(8,9)]);     
[ (1,2,3), (4,5,6), (2,3)(5,6) ] -> [ (7,8,9), (), (8,9) ]
gap> h1 := GroupHomomorphismByImages(g18,s3a,g18gens,[(7,8,9),(7,8,9),(8,9)]);
[ (1,2,3), (4,5,6), (2,3)(5,6) ] -> [ (7,8,9), (7,8,9), (8,9) ]
gap> e1 := GroupHomomorphismByImages(s3a,g18,s3agens,[(1,2,3),(2,3)(5,6)]);   
[ (7,8,9), (8,9) ] -> [ (1,2,3), (2,3)(5,6) ]
gap> C18 := Cat1Group( t1, h1, e1 );
[g18=>s3a]

## Section 2.4.2
gap> Source( C18 );
g18
gap> Range( C18 );
s3a
gap> TailMap( C18 );
[ (1,2,3), (4,5,6), (2,3)(5,6) ] -> [ (7,8,9), (), (8,9) ]
gap> HeadMap( C18 );
[ (1,2,3), (4,5,6), (2,3)(5,6) ] -> [ (7,8,9), (7,8,9), (8,9) ]
gap> RangeEmbedding( C18 );
[ (7,8,9), (8,9) ] -> [ (1,2,3), (2,3)(5,6) ]
gap> Kernel( C18 );
Group([ (4,5,6) ])
gap> KernelEmbedding( C18 );
[ (4,5,6) ] -> [ (4,5,6) ]
gap> Name( C18 );
"[g18=>s3a]"
gap> Size( C18 );
[ 18, 6 ]
gap> StructureDescription( C18 );
[ "(C3 x C3) : C2", "S3" ]

## Section 2.4.3
gap> G4 := Group( (1,2,3,4), (3,4), (5,6,7,8), (7,8) );; 
gap> R4 := Group( (9,10,11,12), (11,12) );;
gap> SetName( G4, "s4s4" );  SetName( R4, "s4d" ); 
gap> G4gens := GeneratorsOfGroup( G4 );; 
gap> R4gens := GeneratorsOfGroup( R4 );; 
gap> t := GroupHomomorphismByImages( G4, R4, G4gens, 
>            Concatenation( R4gens, [ (), () ] ) );; 
gap> h := GroupHomomorphismByImages( G4, R4, G4gens,  
>            Concatenation( [ (), () ], R4gens ) );; 
gap> e := GroupHomomorphismByImages( R4, G4, R4gens, 
>            [ (1,2,3,4)(5,6,7,8), (3,4)(7,8) ] );; 
gap> C4 := PreCat1GroupByTailHeadEmbedding( t, h, e ); 
[s4s4=>s4d]
gap> Display( C4 ); 

Cat1-group [s4s4=>s4d] :- 
: Source group s4s4 has generators:
  [ (1,2,3,4), (3,4), (5,6,7,8), (7,8) ]
: Range group s4d has generators:
  [ ( 9,10,11,12), (11,12) ]
: tail homomorphism maps source generators to:
  [ ( 9,10,11,12), (11,12), (), () ]
: head homomorphism maps source generators to:
  [ (), (), ( 9,10,11,12), (11,12) ]
: range embedding maps range generators to:
  [ (1,2,3,4)(5,6,7,8), (3,4)(7,8) ]
: kernel has generators:
  [ (5,6,7,8), (7,8) ]
: boundary homomorphism maps generators of kernel to:
  [ ( 9,10,11,12), (11,12) ]
: kernel embedding maps generators of kernel to:
  [ (5,6,7,8), (7,8) ]

## Section 2.4.4
gap> R4 := ReverseCat1Group( C4 );
[s4s4=>s4d]
gap> Boundary( R4 );
[ (3,4), (2,3), (1,2,3,4) ] -> [ (11,12), (10,11), (9,10,11,12) ]
gap> TailMap( R4 ) = HeadMap( C4 ); 
true

## Section 2.4.5
gap> s4:=Group( (1,2,3), (3,4) );;  SetName( s4, "s4" ); 
gap> k4 := Subgroup( s4, [ (1,2)(3,4), (1,3)(2,4) ] );;
gap> h := GroupHomomorphismByImages( s4, s4, [(1,2,3),(3,4)], [(),(3,4)] );;
gap> c2 := Image( h );;  SetName( c2, "c2" );
gap> C := PreCat1Group( h, h );
[s4=>c2]
gap> P := PeifferSubgroupPreCat1Group( C );;
gap> P = k4;
true
gap> C2 := Cat1GroupByPeifferQuotient( C );
[Group( [ f1, f2 ] )=>c2]
gap> StructureDescription( C2 );
[ "S3", "C2" ]
gap> XC := PreXModOfPreCat1Group( C );;
gap> StructureDescription( XC );  
[ "A4", "C2" ]
gap> XC2 := XModByPeifferQuotient( XC );;
gap> StructureDescription( XC2 );
[ "C3", "C2" ]
gap> CXC2 := Cat1GroupOfXMod( XC2 );;
gap> StructureDescription( CXC2 );
[ "S3", "C2" ]
gap> IsomorphismCat1Groups( C2, CXC2 );
[[..] => [(..|X..)=>c2]]

## Section 2.5.1
gap> G2 := SmallGroup( 288, 956 );  SetName( G2, "G2" );
<pc group of size 288 with 7 generators>
gap> d12 := DihedralGroup( 12 );  SetName( d12, "d12" );
<pc group of size 12 with 3 generators>
gap> a1 := d12.1;;  a2 := d12.2;;  a3 := d12.3;;  a0 := One( d12 );;
gap> gensG2 := GeneratorsOfGroup( G2 );;
gap> t2 := GroupHomomorphismByImages( G2, d12, gensG2,
>           [ a0, a1*a3, a2*a3, a0, a0, a3, a0 ] );;
gap> h2 := GroupHomomorphismByImages( G2, d12, gensG2,
>           [ a1*a2*a3, a0, a0, a2*a3, a0, a0, a3^2 ] );;                   
gap> e2 := GroupHomomorphismByImages( d12, G2, [a1,a2,a3],
>        [ G2.1*G2.2*G2.4*G2.6^2, G2.3*G2.4*G2.6^2*G2.7, G2.6*G2.7^2 ] );;
gap> C2 := PreCat1GroupByTailHeadEmbedding( t2, h2, e2 );
[G2=>d12]
gap> IsCat1Group( C2 );
true
gap> Display(C2);

Cat1-group [G2=>d12] :- 
: Source group G2 has generators:
  [ f1, f2, f3, f4, f5, f6, f7 ]
: Range group d12 has generators:
  [ f1, f2, f3 ]
: tail homomorphism maps source generators to:
  [ <identity> of ..., f1*f3, f2*f3, <identity> of ..., <identity> of ..., 
  f3, <identity> of ... ]
: head homomorphism maps source generators to:
  [ f1*f2*f3, <identity> of ..., <identity> of ..., f2*f3, <identity> of ..., 
  <identity> of ..., f3^2 ]
: range embedding maps range generators to:
  [ f1*f2*f4*f6^2, f3*f4*f6^2*f7, f6*f7^2 ]
: kernel has generators:
  [ f1, f4, f5, f7 ]
: boundary homomorphism maps generators of kernel to:
  [ f1*f2*f3, f2*f3, <identity> of ..., f3^2 ]
: kernel embedding maps generators of kernel to:
  [ f1, f4, f5, f7 ]

## Section 2.5.1
gap> IsEndomorphismPreCat1Group( C2 ); 
false

## Section 2.5.2
gap> X2 := XModOfCat1Group( C2 );;
gap> Display( X2 );

Crossed module xmod([G2=>d12]) :- 
: Source group has generators:
  [ f1, f4, f5, f7 ]
: Range group d12 has generators:
  [ f1, f2, f3 ]
: Boundary homomorphism maps source generators to:
  [ f1*f2*f3, f2*f3, <identity> of ..., f3^2 ]
: Action homomorphism maps range generators to automorphisms:
  f1 --> { source gens --> [ f1*f5, f4*f5, f5, f7^2 ] }
  f2 --> { source gens --> [ f1*f5*f7^2, f4, f5, f7 ] }
  f3 --> { source gens --> [ f1*f7, f4, f5, f7 ] }
  These 3 automorphisms generate the group of automorphisms.
: associated cat1-group is [G2=>d12]

gap> StructureDescription( X2 );
[ "D24", "D12" ]

## Section 2.6.1
gap> d12 := DihedralGroup( IsPermGroup, 12 );  SetName( d12, "d12" );
Group([ (1,2,3,4,5,6), (2,6)(3,5) ])
gap> AllCat1GroupsNumber( d12 );
12
gap> iso1 := AllCat1GroupsUpToIsomorphism( d12 );;
gap> Length( iso1 );
4
gap> iso1[4];
[d12=>d12]

## Section 2.7.1
gap> L18 := Cat1Select( 18 ); 
Usage:  Cat1Select( size, gpnum, num );
[ "D18", "C18", "C3 x S3", "(C3 x C3) : C2", "C6 x C3" ]
gap> L18_4 := Cat1Select( 18, 4 ); 
Usage:  Cat1Select( size, gpnum, num );
There are 4 cat1-structures for the group (C3 x C3) : C2.
Using small generating set [ f1, f2, f2*f3 ] for source of homs.
[ [range gens], [tail genimages], [head genimages] ] :-
(1)  [ [ f1 ], [ f1, <identity> of ..., <identity> of ... ], 
  [ f1, <identity> of ..., <identity> of ... ] ]
(2)  [ [ f1, f3 ], [ f1, <identity> of ..., f3 ], 
  [ f1, <identity> of ..., f3 ] ]
(3)  [ [ f1, f3 ], [ f1, <identity> of ..., f3 ], 
  [ f1, f3^2, <identity> of ... ] ]
(4)  [ [ f1, f2, f2*f3 ],  tail = head = identity mapping ]
4
gap> C18 := Cat1Select( 18, 4, 3 );
[(C3 x C3) : C2=>Group( [ f1, <identity> of ..., f3 ] )]
gap> iso18 := IsomorphismPermObject( C18 );;
gap> PC18 := Image( iso18 ); 
[Group( [ (2,3)(5,6), (4,5,6), (1,2,3) ] )=>Group( [ (2,3)(5,6), (), (1,2,3) 
 ] )]
gap> X18 := XModOfCat1Group( PC18 ); 
[Group( [ (4,5,6) ] )->Group( [ (2,3)(5,6), (), (1,2,3) ] )]

## Section 2.7.2 
gap> gp := SmallGroup( 102, 2 ); 
<pc group of size 102 with 3 generators>
gap> StructureDescription( gp ); 
"C3 x D34"
gap> all := AllCat1DataGroupsBasic( gp );
#I Edit last line of .../xmod/lib/nn.kk.out to end with ] ] ] ] ]
[ [Group( [ f1, f2, f3 ] )=>Group( [ f1, <identity> of ..., <identity> of ... 
     ] )], [Group( [ f1, f2, f3 ] )=>Group( [ f1, f2, <identity> of ... ] )], 
  [Group( [ f1, f2, f3 ] )=>Group( [ f1, <identity> of ..., f3 ] )], 
  [Group( [ f1, f2, f3 ] )=>Group( [ f1, f2, f3 ] )] ]

## Section 2.7.1
gap> IdGroup( X2 );
[ [ 24, 6 ], [ 12, 4 ] ]
gap> IdGroup( C2 );
[ [ 288, 956 ], [ 12, 4 ] ]

gap> SetInfoLevel( InfoXMod, saved_infolevel_xmod );; 
gap> SetInfoLevel( InfoGroupoids, saved_infolevel_groupoids );; 
gap> STOP_TEST( "gp2obj.tst", 10000 );
